Functional Reactive Programming on Android With RxJava
------------------------------------------------------

Shameless plug: if after reading this article, you want to know more,
come hear me talk at [DroidCon UK 2013](http://uk.droidcon.com/2013/lineup/)!

If you are an application developer, there are two inconvenient truths:

1.  Modern applications are inherently concurrent.
2.  Writing concurrent programs that are correct is difficult.

In the domain of mobile or desktop applications, parallel execution
allows for responsive user interfaces because we can move computations
into the background while the UI responds to ongoing user interactions.
Code must execute concurrently to not stray from this fundamental
requirement. Writing such programs is diffcult because on mobile they
are typically written in imperative languages like C or Java. Writing
concurrent code in imperative languages is difficult because code is
written in terms of interweaved, temporal instructions that move objects
or data structures from one state to another. This imperative style of
programming inherently produces side effects. It presents several
problems when running instructions in parallel, such as race conditions
when writing to a shared resource.

Resistance is futile–or is it?
==============================

Developers have grown accustomed to the drawbacks of expressing
concurrency in imperative languages. On platforms like Android where
Java is (still) the dominant language, concurrency simply sucks, and we
should just give in and deal with it. I personally keep a close eye on
the server side end of the spectrum. Over the past few years, functional
programming has made an astounding comeback in terms of rate of adoption
and innovation, the details of which I will not get into here. In the
case of concurrency, functional programming has a very simple answer to
dealing with shared state: don’t have it.

Problems of concurrent programming with AsyncTask
-------------------------------------------------

Being based on Java, Android comes with a standard number of Java
concurrency primitives such as `Thread`s and `Future`s. While these
tools make it easy to perform simple asynchronous tasks, they are fairly
low level and require a substantial amount of diligence when you use
them to model complex interactions between concurrent objects. A
frequent use case on Android or any UI-driven application is to perform
a background job and then update the UI with the result of the
operation. Android provides `AsyncTask` for exactly that:


    class DownloadTask extends AsyncTask<String, Void, File> {

      protected File doInBackground(String... args) {
        final String url = args[0];
        try {
          byte[] fileContent = downloadFile(url);
          File file = writeToFile(fileContent);
          return file;
        } catch (Exception e) {
          // ???
        }
      }

      protected void onPostExecute(File file) {
        Context context = getContext(); // ???
        Toast.makeText(context,
            "Downloaded: " + file.getAbsolutePath(),
            Toast.LENGTH_SHORT)
            .show();
      }
    }


This looks straightforward. Define a method `doInBackground` that
accepts something through its formal parameters, and returns something
as the result of the operation. Android guarantees that this code will
execute in a thread that is not the main user-interface thread. We also
define a UI callback function `onPostExecute` that receives the result
of the computation and can consume it on the main UI thread, since
Android guarantees that this method will always be invoked on the main
thread.

### In search for the jigsaw-puzzle pieces

So far so good. What’s wrong with this picture? Let’s start with
`doInBackground`, which downloads a file–a costly operation because it
involves network and disk I/O. There are many things that can go wrong,
so we want to recover from errors, and add a try-catch block. What do we
do in the catch block? Log the error? Perhaps we want to inform the user
about this error too, which likely involves interacting with the UI.
Wait, we cannot do that because we are not allowed to update any
user-interface elements from a background thread. Bummer.

It should be easy to handle that error in `onPostExecute`. We might
reason that it is as simple as holding on to the exception in a private
field (i.e. we write it on the background thread), and check in
`onPostExecute` (i.e. read it on the UI thread) if that field is set to
something other than null (did I mention we love null checks) and
display it to the user in some way shape or form. But wait, how do we
obtain a reference to a `Context`, without which we cannot do anything
meaningful with the UI? Apparently, we have to bind it to the task
instance up front, at the point of instantiation, and keep a reference
to it throughout a task’s execution. But what if the download takes a
minute to run? Do we want to hold on to an `Activity` instance for an
entire minute? What if the user decides to back out of the Activity that
triggered the task, and we are holding on to a stale reference. This not
only creates a substantial memory leak, but is also worthless because
meanwhile it has been detached from the application window. A problem
that [everyone is well aware of](https://www.google.de/search?q=asynctask+configuration+change).

### Beyond the basics

There are other problems with all this. The preceding task is incredibly
simple. Picture a more complicated scenario where we need to orchestrate
a number of such operations. For example, we might want to fetch some
JSON from a service API, parse it, map it, filter it, cache it to disk,
and only then feed the result to the UI. All the aforementioned
operations should–as per the single responsibility principle–exist as
separate objects, perhaps exposed through different services. It is
difficult and non-intuitive to use `AsyncTask` because it requires
grouping any number of combinations of service interactions into
separate task classes. This results in a proliferation of meaningless
task classes, from the perspective of your business logic.

Another option is to have one task class per service-object invocation,
or wrap the service objects themselves in `AsyncTasks`. Composing
service objects means nesting `AsyncTask`, which leads to what is
commonly referred to as “callback hell” because you start tasks from a
task callback from a task callback from a … you get the idea.

Last but not least, `AsyncTask`s scheduling behavior varies
significantly across different versions of Android. It’s changed from a
capped thread pool in the 1.x days (with varying bounds depending on the
API level) to a *single thread executor* model in 4.x. Read that again.
Your tasks (plural) do *not* run concurrently to each other on ICS
devices and beyond (although they do run concurrently to the main UI
thread). Why did Google decide to serialize task execution? Developers
could not get it right, applications suffered from nasty problems due to
race conditions and incorrectly synchronized code.

### The inconvenient truth

Should we still use `Thread` and `AsyncTask`?

The answer is “probably”. For simple, one-shot jobs that do not require
much orchestration, `AsyncTask` is fine. For anything more complex it is
doable, but requires juggling with `volatile`s, `WeakReference`s, `null`
checks, and other [defensive, unconfident mechanisms](http://devblog.avdi.org/2012/06/05/confident-ruby-beta/).
Perhaps worst of all, it requires you to think about things that have
nothing to do with the problem that you set out to solve, which is  
 to download a file.

Enter RxJava–now with more Android
==================================

To come back to the initial problem statement, do we have to give in to
the lack of high-level abstractions and deal with it, or do better
solutions exist? Turns out that functional programming might have an
answer to this. “But wait” you might say, “I still wanna use Java?”.
Turns out, yes, you can. It is not super pretty (at least not unless
Google whips out its magic wand and gives us Java 8 and closures on
Dalvik, or unless you feel attracted to anonymous classes and six levels
of identation). However, it solves all of the problems in one fell
swoop:

-   No standard mechanism to recover from errors
-   Lack of control over thread scheduling (unless you like to dig deep)
-   No obvious way to compose asynchronous operations
-   No obvious and hassle-free way of attaching to `Context`

[RxJava](https://github.com/Netflix/RxJava) is an implementation of the
Reactive Extensions (Rx) on the JVM, courtesy of Netflix. Rx was first
conceived by Erik Meijer on the Microsoft .NET platform, as a way of
combining data or event streams with reactive objects and functional
composition. In Rx, events are modeled as observable streams to which
observers are subscribed. These streams, or observables for short, can
be filtered, transformed, and composed in various ways before their
results are emitted to an observer. Every observer is defined within
three messages: `onNext`, `onCompleted`, and `onError`. Concurrency is a
variable in this equation, and abstracted away in the form of
schedulers. Generally, every observable stream exposes an interface that
is modeled after concurrent execution flows (i.e. you don’t call it, you
subscribe to it), but by default is executed synchronously. Introducing
schedulers can make an observable execute using various concurrency
primitives such as threads, thread pools, or even Scala actors. Here is
an example:

    Subscription sub = Observable.from(1, 2, 3, 4, 5)
        .subscribeOn(Schedulers.newThread())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe(observer);

    // ...

    sub.unsubscribe();

This creates a new, observable stream from the given list of integers,
and emits them one after another on the given observer. The use of
`subscribeOn` and `observeOn` configures the stream to emit the numbers
on a new `Thread`, and to receive them on the Android main UI thread.
For example, the observer’s `onNext` method is called on the main
thread. Eventually, you unsubscribe from the observable. Here is an
example `Observer` implementation:

    public class IntObserver implements Observer<Integer> {

      @Override
      public void onNext(Integer value) {
         System.out.println("received: " + value);
      }

      // onCompleted and onError omitted
      ...
    }

For something more interesting, you can implement the download task as
an Rx `Observable`:

    private Observable<File> downloadFileObservable() {
        return Observable.create(new OnSubscribeFunc<File>() {
            @Override
            public Subscription onSubscribe(Observer<? super File> fileObserver) {
                try {
                    byte[] fileContent = downloadFile();
                    File file = writeToFile(fileContent);
                    fileObserver.onNext(file);
                    fileObserver.onCompleted();
                } catch (Exception e) {
                    fileObserver.onError(e);
                }
                return Subscriptions.empty();
            }
        });
    }

The preceding example creates a method that builds an `Observable`
*stream*, which in this case only ever emits a single item (the file) to
which a `File` observer can connect. Whenever this observable is
subscribed to, its `onSubscribe` function triggers and executes the task
at hand. If the task can be carried out successfully, deliver the result
to the observer through `onNext` so `onNext` can properly react to it.
Then signal completion by using `onCompleted`. If an exception is
raised, deliver it to the observer through `onError`. As an example, you
can use this from a `Fragment`:

    class MyFragment extends Fragment implements Observer<File> {
      private Subscription subscription;

      @Override
      protected void onCreate(Bundle savedInstanceState) {
        subscription = AndroidObservables.fromFragment(this, downloadFileObservable())
                              .subscribeOn(Schedulers.newThread())
                              .subscribe(this);
      }

      private Observable<File> downloadFileObservable() { /* as above */ }

      @Override
      protected void onDestroy() {
        subscription.unsubscribe();
      }

      public void onNext(File file) {
        Toast.makeText(getActivity(),
            "Downloaded: " + file.getAbsolutePath(),
            Toast.LENGTH_SHORT)
            .show();
      }

      public void onCompleted() {}

      public void onError(Throwable error) {
        Toast.makeText(getActivity(),
            "Download failed: " + error.getMessage(),
            Toast.LENGTH_SHORT)
            .show();
      }
    }

By using RxJava, the aforementioned issues are solved all at the same
time. The `fromFragment` call transforms the given source observable in
such a way that events will only be emitted to the fragment if it’s
still alive and attached to its host activity. Call `unsubscribe` in
`onDestroy` to ensure that all references to the fragment, which is also
the observer, are released.

You can have proper error handling through an observer’s `onError`
callback. Also, you can execute the task on any given scheduler with a
simple method call. Doing so gives you fine-grained control over where
the expensive code is run and where the callbacks will run, all without
you having to write a single line of synchronization logic. Futhermore,
RxJava allows you to compose and transform observables to obtain new
ones, which enables you to reuse code easily. For example, to not emit
the `File` itself, but merely its path, transform the *existing*
observable:

    Observable<String> filePathObservable = downloadFileObservable().map(new Func1<File, String>() {
        @Override
        public String call(File file) {
            return file.getAbsolutePath();
        }
    });

    // now emits file paths, not `File`s
    subscription = filePathObservable.subscribe(/* Observer<String> */);

You can see how powerful this way of expressing asynchronous
computations is. At [SoundCloud](https://soundcloud.com), we are moving
most of our code that relies heavily on event-based and asynchronous
operations to Rx observables. For convenience, we contributed
`AndroidSchedulers` that schedule an observer to receive callbacks on a
`Handler` thread. See [rxjava-android](https://github.com/Netflix/RxJava/tree/master/rxjava-contrib/rxjava-android).
We are also in the process of contributing those operators back that
allow observing observables from Fragments and Activities in an easy and
safe way, as seen in the previous example.

In a nutshell, RxJava finally makes concurrency and event-based
programming on Android hassle free. Note that we follow the same
strategy on iOS using GitHub’s [Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) library because
we have committed ourselves to the functional-reactive paradigm. We
think that it is an exciting development that leads to code that is more
stable, easier to unit test, and free of low-level state or concurrency
concerns that would otherwise take over your service objects.

To hear more about this topic, watch this [interview with our Director
of Mobile Engineering on Root Access Berlin](http://backstage.soundcloud.com/2013/08/responsive-android-applications-with-sane-code/) and come see me at [DroidCon UK 2013](http://uk.droidcon.com/2013/lineup/) where I will be speaking about RxJava and its use in the SoundCloud application on the developer
track.

Aug 25th, 2013

Copyright © 2014 Matthias Käppler
