Top 7 Tips for RxJava on Android
================================

January 28, 2014

[![Timo
Tuominen](http://blog.futurice.com/wp-content/uploads/2014/01/Timo-Tuominen_avatar_1389800422.png)](http://blog.futurice.com/author/ttuo)

by **[Timo Tuominen](http://blog.futurice.com/author/ttuo)**

Senior Software Developer

### Topics

[Android](http://blog.futurice.com/tag/android), [Functional
Programming](http://blog.futurice.com/tag/functional-programming),
[RxJava](http://blog.futurice.com/tag/rxjava)

Last November I found myself at Futurice in London starting a
challenging project that seemed to be the perfect candidate for a more
immersive reactive system. We made the bold decision to build the entire
Android architecture in RxJava. Little did we know at that time, though,
just how deep the dive would be. After a few initial encouraging
experiments we were surrounded by eerie problems and sleepless nights.
Some usual solutions became impossible as they did not play with the
system. Instead of null pointer exceptions we were debugging threading
issues. Stack Overflow became even less relevant than usually.

Curiously enough, there was no desire to turn back. It was clear the
reactive way was the right way and anything else would have felt but an
ugly compromise. That is, in fact, the funny thing about reactive — no
matter how hard it is in the beginning, it always feels it is worth it.

Fast-forward a few months, and we have an app with dense but clean code
and an usually good test coverage of critical domain logic.

Prerequisites
-------------

This article is the article I would have liked to read myself before
starting on the path of RxJava on Android. It is for the reader who
wishes to gain a better understanding of how it is used in practice when
used on a larger scale.

As a quick primer consider the following Observer-Operation-Subscriber
chain:

[![top-7-tips-for-rxjava-on-android\_hot\_subscription](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_hot_subscription.png)](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_hot_subscription.png)

Here the Observable emits an integer, it goes through an operation that
adds 2 to it, and is finally received by the Subscriber (Observer). All
steps are asynchronous, which means the subscriber does not actually
know that the original value had been changed. It could, in fact, be
this:

[![top-7-tips-for-rxjava-on-android\_google\_search](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_google_search.png)](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_google_search.png)

If you are not familiar with the concept of functional reactive
programming (FRP), Olli Salonen wrote [a wide-spread post about
Rx](http://blog.futurice.com/tech-pick-of-the-week-rx-for-net-and-rxjava-for-android)
a while ago. It remains an excellent primer to the topic, and I invite
you to read if have not yet done so.

My Top 7 things to know about RxJava on Android
===============================================

1. By default, RxJava is synchronous
------------------------------------

Despite what I just said, plain subscriptions are executed
synchronously. This makes testing a lot easier and in some cases you can
cut corners if you know what you are doing. If you create a stream from
a an array with Observable.from, you know any subscriptions will be
invoked immediately. Just never trust subscriptions you receive from
outside are synchronous!

2. Hot and cold subscriptions
-----------------------------

Usually observables only start doing their thing when someone is
interested. A cold observable is one to which no one has subscribed, and
is thus inanimate:

[![top-7-tips-for-rxjava-on-android\_cold\_subscription](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_cold_subscription.png)](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_cold_subscription.png)

Depending on the implementation of an Observable, it might start a new
operation every time it gets a new subscriber. This one, for example,
sends the number 5. The operation of adding 2 does not create a
subscription, but only processes the emitted values once someone
subscribes.

The easiest way to wrap your head around this is to look at the
Observer.create — you define an onSubscribe function as its core and it
is executed every single time someone subscribes to your newly-created
observable. It is up to you whether you keep some state in the
observable or spin out something completely new every time.

Let us try an example. If we add a random number to the emitted one,
each subscriber will get a different number:

[![top-7-tips-for-rxjava-on-android\_randomise\_operation](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_randomise_operation.png)](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_randomise_operation.png)

This is because the onSubscribe is executed separately for every new
subscriber. However, if we add a special operation called
[.cache](https://github.com/Netflix/RxJava/wiki/Observable-Utility-Operators#cache),
we can save the values and everyone receives the same ones:

[![top-7-tips-for-rxjava-on-android\_randomise\_operation\_cached](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_randomise_operation_cached.png)](http://blog.futurice.com/wp-content/uploads/2014/01/top-7-tips-for-rxjava-on-android_randomise_operation_cached.png)

The interval is another good example. If you subscribe to the same
interval observable many times, each subscription will start the count
from zero. If you want to have an interval that always gives the same
numbers to all observers, you could convert the interval into a cached
observable. Then whoever subscribes to the interval would get all
numbers so far and then continue receiving the new ones as they come.
Internally, what happens with cache is it subscribes to the source (i.e.
interval) and has everyone subscribe to itself instead.

I have made a little [self-contained example](https://github.com/tehmou/RxJava-code-examples/blob/master/src/test/java/RxJavaCacheTest.java)
of the behaviour of the cache. It is a bit different from the one
discussed, but is more illustrative as code.

3. Use subjects when in trouble
-------------------------------

While a last resort, subjects can greatly help you understand how Rx
works and provide you with temporary solutions. A subject can both
receive and send values (observe and be observed). Sometimes it is easy
to make the first implementation with an appropriate subject and then
see how it could be eliminated. The implied danger lies in exposing the
subject to the outside world. Operations are meant to be atomic and
encapsulated, but a subject breaks this by letting outsider call its
methods. When sharing a subject, you should cast it into an Observable
to prevent further modifications.

The PublishSubject is the most straightforward of them, and thus also
the most useful: whenever its onNext/onComplete/onError is called, it
will redirect it to all of its subscribers. It acts as an event bus of a
kind — as long as you do not send onComplete or onError, the
subscriptions remain alive and receive the onNext events. On completion
or an error, RxJava automatically terminates the subscription,
preventing further onNext events.

For instance, if you want to make a BehaviourSubject without a required
initial value, you could do this:

    import rx.Observable;
    import rx.subjects.PublishSubject;
    import rx.subjects.Subject;

    public class CachedValue {
        final private Subject<T, T> subject = PublishSubject.create();
        private boolean lastValueSet = false;
        private T lastValue;

        public CachedValue() { }

        public CachedValue(T initialValue) {
            lastValueSet = true;
            lastValue = initialValue;
        }

        public void setValue(T value) {
            if (!lastValueSet || value != lastValue) {
                lastValueSet = true;
                lastValue = value;
                subject.onNext(lastValue);
            }
        }

        public Observable getObservable() {
            if (lastValueSet) {
                return Observable.merge(Observable.from(lastValue), subject);
            } else {
                return subject;
            }
        }
    }

Of course this implementation is not pretty, but since the Observable
class is not an interface the only “proper” way would be to write a new
kind of an Observable altogether. This is, however, a bit more involved.
If you need to create your own observable it usually means you are doing
something wrong. In this scenario, it would probably be better to simply
use the standard BehaviourSubject instead, and set the default value to
null ( accompanied by null checks on the receiving end).

4. Pay attention to the thread
------------------------------

Whenever you need to execute an asynchronous operation as part of the
observable, threading will inevitably come into the picture. Normally
there is no need to force the thread to go out of the main thread, but
when it does, you need to make sure it comes back before you make
changes to the UI.

If you wish to change the thread on which the operation is performed you
can call subscribeOn(). To get back to the main thread use
observeOn(AndroidSchedulers.mainThread()). However, notice that whenever
you force the operation onto a specific thread, it will always make the
subscription asynchronous.

Some experts recommend doing the switch to the main thread as close to
the view as possible, but we found it more practical to do this already
in the data layer, immediately after the operation is completed. In
fact, the value might be coming synchronously from the cache, in which
case forcing a switch to the main thread will cause a delay in the
rendering. Worse, we had many subscriptions from views to their view
models that were supposed to be executed during the same main loop
frame, but calling observeOn for each of them caused them to be posted
to the handler separately.

Whatever you end up doing, just make sure you do it in a consistent
manner to avoid strange issues.

For an example of an asynchronous http observable [see this post](http://mttkay.github.io/blog/2013/08/25/functional-reactive-programming-on-android-with-rxjava/)
by Matthias Käppler.

Another thing worth mentioning is that your custom Observable cannot be
unsubscribed from until its onSubscribe function has finished. This
means that if, for instance, your HTTP request blocks the thread, your
Observable can never be unsubscribed from. Sometimes this does not
matter, but it could become an especially big bottleneck with dynamic
lists if you are unable to abort the requests as the views are recycled.

5. Read the RxJava wiki and look at the diagrams
------------------------------------------------

[You can find the official documentation here.](https://github.com/Netflix/RxJava/wiki)

Netflix team has put together some enlightening state diagrams to
describe the features of RxJava. It is worthwhile to read them through
to get an understanding of what is already there. Skip the ones targeted
to parallel computing, though, unless you are doing something really
exotic with your data.

If you are not familiar with Scala, some of the notations used in the
RxJava documentation might seem strange, but fortunately they all have
straight-forward Java alternatives. The lambda function (-\>) is usually
simply converted into an Action1 anonymous class.

Here are some of the RxJava functions I found the most useful:

[Observable.from()](https://github.com/Netflix/RxJava/wiki/Creating-Observables#from)  
 Converts an iterable into an observable that emits all items in the
iterable and then calls onComplete. The resulting observable will work
synchronously.

[Observable.just(\<Object\>)](https://github.com/Netflix/RxJava/wiki/Creating-Observables#just)  
 Like from, but does not try to iterate the object it is given. It will
simply emit the object in onNext and then call onComplete.

[Observable.create](https://github.com/Netflix/RxJava/wiki/Creating-Observables#create)  
 If you are able to wrap everything you need in an observable into a
single closure, you can use this to create your very own observable.

[Observable.merge](https://github.com/Netflix/RxJava/wiki/Combining-Observables#merge)  
 Combine two or more observables into one. You can even use observables
of observables.

[Observable.error](https://github.com/Netflix/RxJava/wiki/Creating-Observables#empty-error-and-never)  
 Creates an observable that only emits an error.

[.map](https://github.com/Netflix/RxJava/wiki/Transforming-Observables#map)  
 Very basic, maps all values of a stream into another type by performing
a custom function. You could, for instance, cast strings into integers
this way.

[.filter](https://github.com/Netflix/RxJava/wiki/Filtering-Observables#filter-or-where)  
 Give it a function that returns true or false based on the next value.
If you return false, the value will be filtered out.

[.combineLatest](https://github.com/Netflix/RxJava/wiki/Combining-Observables#combinelatest)  
 Take the last values of two observables and execute a function that
receives both of them, returning a new value based on them. The function
is executed whenever one of the values is changed. If you have two
independent http requests, you can use combineLatest to process them
when both are ready.

[.zip](https://github.com/Netflix/RxJava/wiki/Combining-Observables#zip)  
 A bit like combineLatest, but puts out a new value only when there is a
new value from both (all) the source observables. It does not “reuse”
any of the source values.

[.mapMany /
.flatMap](https://github.com/Netflix/RxJava/wiki/Transforming-Observables#mapmany-or-flatmap-and-mapmanydelayerror)  
 Great for chaining observables, such as async HTTP calls that need the
previous value to start the next. You can use the value from the source
observable and return a new observable based on it. The new observable
will be flattened to the same stream, making the operation transparent
to the outside.

[.cache](https://github.com/Netflix/RxJava/wiki/Observable-Utility-Operators#cache)  
 Normally whenever you subscribe to an observable, it will trigger the
onSubscribe function, potentially starting a new operation. If you call
.cache() on it, it creates a barrier of sorts, only returning the cached
values to all subscribers. This means the subscription never goes all
the way through to the original source, but stops at the cache. See the
Tip 2 for a further example of the cache function.

6. Subscribing with Observer vs. Action
---------------------------------------

The RxJava Observable subscribe has many overloads. You can choose to
implement an entire Observer with onNext, onComplete and onError, or
only some of these in the form of an Action1. Action1 in Java basically
lets you have one function as a closure of sorts.

A convenient override .subscribe(Action1 onNext) subscribes you to the
observable and calls the action only on every onNext event that it
receives. However, if onError is sent by the observable it will throw an
IllegalArgumentException. A good pattern to prevent this is to create an
ErrorLoggingObserver in between that only logs and eats the error but
passes through onNext and onComplete. Another option is to use the
subscribe(Action1 onNext, Action1 onError) or implement a complete
Observer.

7. Subscriptions leak memory
----------------------------

By subscribing to an observable, you give it a strong reference to the
observer. If the observer is a closure (i.e. anonymous class), it has
reference to its surrounding instance. As a result, the observer will
not be garbage collected as long as the observable is alive.

A call to subscribe returns a subscription, which can be unsubscribed
from at any point. However, determining a proper point for unsubscribing
in Android is sometimes challenging — or impossible.

Firstly, let us consider that singletons are not garbage collected, as
they are implemented as static members of a class. This is of course the
idea. Secondly, let us implement a data store as a singleton. It
retrieves a live Twitter feed at periodic intervals, never sending
onComplete.

Now, we want to render these values in a view. It’s time to subscribe.
But wait, now the observable, the static data store, has a strong
reference to our view, making it stay alive indefinitely! This is very
bad.

It is possible only to use WeakReferences of the views to avoid this.
Unfortunately it is non-trivial to build this into the observables
themselves, not least because they tend to wrap the onSubscribe
functions with decorators. Your choices are to create a custom
WeakReference scheme in your application, or to make sure everything is
properly unsubscribed from.

The most obvious way is to have activities and fragments handle all
subscriptions to static instances and unsubscribe accordingly. This
would include not letting views make subscriptions to static instances
at all. For this approach you can also check the AndroidObservable
operation in the RxJava to tie the observable to an activity or a
fragment. It, for instance, deactivates the observable if the fragment
is not added.

This topic is much discussed, and you can find some insights here:  
 [MSDN Weak subscribe forum thread](http://social.msdn.microsoft.com/Forums/en-US/c8112371-e18a-4610-a840-53d1f81761ee/weak-subscribe)  
 [Discussion of RxJava weak subscriptions](https://github.com/Netflix/RxJava/issues/386)  
 [AndroidObservable operation pull request](https://github.com/soundcloud/RxJava/issues/1)  
 [AndroidObservable source code](https://github.com/Netflix/RxJava/blob/master/rxjava-contrib/rxjava-android/src/main/java/rx/android/observables/AndroidObservable.java)

Summary
-------

Using RxJava for individual tasks is low risk and potentially high gain.
It can simplify your code considerably. However, the more you use Rx in
your project, the more likely you are to see a domino effect of a
reactive expansion. Bridging the gap between non-Rx and Rx parts can be
troublesome, and it can become tempting to simply write everything in
Rx. This, on the other hand, is a decision not easily made. While
indescribably deliberating, you will be wandering into a new land with
unthinkable possibilities but with very little help.

