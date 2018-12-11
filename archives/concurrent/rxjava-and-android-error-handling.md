RxJava and Android: error handling
==================================

This is a follow-up to a post titled [Using RxJava with
Android](http://howrobotswork.wordpress.com/2013/10/28/using-rxjava-in-android/).
If you’re not familiar with RxJava, I recommend reading it before you
continue.

If you’re working with async processes, transparent error handling is a
must for adequate user experience. This example is about calling a REST
service, where error handling is particularly important: as networking
is sensitive, it always requires some sort of retry, timeout and failure
mechanism. RxJava is built for creating fault-tolerant apps, this
tutorial will show you the basics.

Error handling possibilities in RxJava
--------------------------------------

The RxJava library has pretty good built-in error handling capabilities,
which can be used with only a few lines of code. So the good news is
there’s no need for heavy exception handling, costly timing and
conditional retry operations, and you only have to implement it once per
subscription (not once per observable), thanks to error propagation.
Wrap everything in a *try* block, then call the *observer.onError()*
with the exception as a param in the *catch* block to propagate the
error to the observer.

There are a couple of ways of handling an error:

-   supply an *Action1()* instance in the *subscribe()* function
-   override the supplied Observer’s onError(Throwable) method
-   call one of the error handling operators

The first two are pretty straightforward, all they do is trigger a
*call* method with the exception. From this point on, it’s the
developers’ job to handle the error. Since this call occurs after all
retry operations fail, it is mostly a point of absolute failure. This
means it is a good spot for informing the user about the error.
Implementation is a piece of cake a look at the code below, which shows
how to use Action1.

    .subscribe(new Action1<Object>() {
            @Override
            public void call(Object o) {
                // do something with the result
            }
        }, new Action1<Throwable>() {
            @Override
            public void call(Throwable throwable) {
                // do something with the error                            
            }
        });

The great thing about error propagation is that it doesn’t matter how
long is the chain of observables, the error will be bubbled up to the
subscription at the top, meaning there is no need for redundant
(per-observable) implementation.

Error handling operators
------------------------

Let’s start with *retry*, which is one of the most often required
features; usage is pretty straightforward. Calling this function before
subscribing to an observable will result in resubscribing to it when an
error occurs (eg. at an *onError* callback). Translated to the example:
if the API call fails, the code will automatically subscribe to it
again, causing it to try again. *Retry()* has an int parameter as the
number of retry attempts, but it can be called with no param, causing it
to retry as long as there is an error. All by adding an extra function
call.

The other methods are also quite useful. Quoted from the [official
wiki](https://github.com/Netflix/RxJava/wiki/Error-Handling-Operators):

-   [onErrorResumeNext](https://github.com/Netflix/RxJava/wiki/Error-Handling-Operators#onerrorresumenext):
    instructs an Observable to continue emitting items after it
    encounters an error
-   [onErrorReturn](https://github.com/Netflix/RxJava/wiki/Error-Handling-Operators#onerrorreturn):
    instructs an Observable to emit a particular item when it encounters
    an error
-   [onExceptionResumeNextViaObservable](https://github.com/Netflix/RxJava/wiki/Error-Handling-Operators#onexceptionresumenextviaobservable):
    instructs an Observable to continue emitting items after it
    encounters an exception (but not another variety of throwable)

*Sidenote:* it is sometimes a requirement to wait for some time instead
of calling retry immediately when an API call fails. Sadly, this is not
implemented in RxJava out-of-the-box, but can be achieved with a little
of extra code. Just create a wrapper around the API call with timeout
capabilities based on the number of retries.

Unsubscribing from the Observer
-------------------------------

An other important thing is to cancel the subscription if necessary.
When your activity or fragment is destroyed, the odds are good that you
no longer need the result of the async calls, and fiddling around in the
UI in subscribe’s call function will result in a nasty exception,
because your views won’t exist. Avoiding this is easy: simply call an
*unsubscribe* in the activitys *onDestroy()* method or the fragments
*onDestroyView()* function.

If you have multiple subscriptions in an activity or fragment, it might
be a good idea to wrap them into a
[CompositeSubscripton](http://netflix.github.io/RxJava/javadoc/rx/subscriptions/CompositeSubscription.html).
This way you’ll only have to call *unSubscribe()* once, all the
subscriptions held by the CompositeSubscripton will be unsubscribed.

Keep in mind that the *unsubscribe* method only unsubscribes the
observer (eg. stops receiving notifications on the Observer associated
to it). If you do any blocking operations in the onSubscribe method,
it’s up to you, to cancel them, if possible. For example if use
HttpURLConnection to access some resource on the network (detailed
below), you can call the *disconnect()* method to actually cancel the
async operation. Similar to this, with the Apache HTTP Client you can
use the HttpGet, HttpPost, etc. *abort()* methods.

    Observable.create(new Observable.OnSubscribeFunc() {

        HttpURLConnection urlConnection;

        @Override
        public Subscription onSubscribe(final Observer<? super String> observer) {
            final Thread thread = new Thread() {

                @Override
                public void run() {
                    try {
                        urlConnection = (HttpURLConnection) new URL("http://ipv4.download.thinkbroadband.com/50MB.zip").openConnection();
                        urlConnection.connect();
                        final InputStream inputStream = new BufferedInputStream(urlConnection.getInputStream());
                        final File file = new File("test.file");
                        if (!file.exists()) {
                            file.createNewFile();
                        }
                        ByteStreams.copy(inputStream, new BufferedOutputStream(new FileOutputStream(file)));
                        observer.onNext("Done");
                        observer.onCompleted();
                    } catch (Exception e) {
                        // note that Observer.onError won't be called after unsubscribing
                        observer.onError(e);
                    }
                }

            };
            thread.start();
            return Subscriptions.create(new Action0() {

                @Override
                public void call() {
                    // a SocketException will be thrown on the new thread
                    if(urlConnection != null) {
                        urlConnection.disconnect();
                    }
                }

            });
        }

    });

Returning a *Subscriptions.empty()* in *Observable.create()* results in
a subscription that [does nothing when
unsubscribed](https://github.com/Netflix/RxJava/blob/master/rxjava-core/src/main/java/rx/subscriptions/Subscriptions.java),
besides sending an interrupt signal to the thread. So it is advised to
take care of cleaning up after yourself.

Timeout in RxJava
-----------------

When doing time-sensitive work, sometimes the application can’t wait
until the async thread returns, it is a requirement to set a timeout.
This can be easily done with the *timeout()* function, which takes an
int and a timeunit as parameters. Again, this requires only one extra
line.

If the work doesn’t finish before the timeout expires, a
[java.util.concurrent.TimeoutException](http://docs.oracle.com/javase/7/docs/api/java/util/concurrent/TimeoutException.html)
is thrown, which can be handled as a standard exception, as described
above.

Wrap-up
-------

Error handling with RxJava is quite simple in the common cases, retry,
timeout and co. come in handy when doing failure-prepared async jobs in
the background. Observables armed with a combination of the features
explained in this post can add a huge boost to the user experience when
it comes to networking or other asynchronous work, and error propagation
allows the developer to only implement error handling once per
observable chain.
