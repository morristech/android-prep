RxJava and Android: working with subjects
=========================================

*This is a follow-up to a post titled [Using RxJava with
Android](http://howrobotswork.wordpress.com/2013/10/28/using-rxjava-in-android/).
If you’re not familiar with RxJava, I recommend reading it before you
continue.*

RxJava’s observers and observables offer a great way to manage multiple
threads and async processes in Android development. Besides these, the
library also offers subjects, which are perfect for long running async
processes with periodic updates, consumed by multiple observers.

Let’s start by clearing the air on subjects! Quoted from the RxJava wiki
page:

> A Subject is a sort of bridge or proxy that acts both as an Observer
> and as an Observable. Because it is an Observer, it can subscribe to
> one or more Observables, and because it is an Observable, it can pass
> through the items it observes by reemitting them, and it can also emit
> new items.

The problem and the solution
----------------------------

Subjects are quite handy when working with periodically updated data,
where freshness is a requirement in most parts of the app’s lifecycle,
throughout multiple activities. This is a common case in Android
development, just consider the following examples:

-   location-based services
-   working with sensors
-   periodic polling

As the async nature of these cases, managing them with RxJava is a good
choice. We’re talking about long-running procedures (required to be
available for an indefinite period, eg. while the user is using certain
functions), possibly spanning through multiple activities (meaning
multiple consumers for the same data), which can be absolved by creating
a sole subject serving all of the requests. The subject can be kept
alive just as long as it is needed, which means the initialisation phase
runs only once, observers can subscribe and unsubscribe on-demand, while
the subject emits items periodically/if necessary. Certain subjects also
emit specific items when subscribed to, meaning you don’t have to wait
for valid seed data.

There are four types of subjects, each one designed to be used in a
specific use-case. The [RxJava wiki
page](https://github.com/Netflix/RxJava/wiki/Subject) does a great job
explaining them, so I’ll just sum them up in a few sentences, I
recommend [said site](https://github.com/Netflix/RxJava/wiki/Subject)for
the details.

-   *AsyncSubject* – emits the last item emitted by the source
    observable when it completes
-   *BehaviorSubject* – emits the last emitted item when subscribed to,
    then continues to emit items from the source observable
-   *PublishSubject* – only emits items which were emitted by the source
    observable after subscription
-   *ReplaySubject* – emits every emitted item to subscribers

Subjects in action
------------------

Let’s see the concept in action! A practical example is
location-monitoring: consider a LBS which needs your location every 30
seconds. Getting a Location value from a LocationClient consists of the
following steps:

-   configuring the LocationRequest
-   implementing required callback methods
-   initialising and connecting to the LocationClient instance
-   implementing a LocationListener
-   requesting location updates

Connecting and positioning takes time, so if an app requires location
data constantly, it’s a good idea to put the LocationClient somewhere
centralised, not binding it to activities/fragments. This way the
LocationClient is only created once, so there is no need to run the
occasionally time-consuming initialising methods (so navigating to a new
activity won’t stall functionality), not to mention the
always-up-to-date data. This can be easily done by putting a static
instance into the Application subclass or via the singleton pattern.

First thing to do is wrap the positioning logic into a *subject*; the
best fit for this problem is the *BehaviourSubject*. We’ll start
monitoring location in the *onCreate* of the Application subclass (of
course this can be postponed to when your app actually needs the data).
This way the subject will emit the last location right when subscribed
to, meaning you’ll get fresh data at subscription-time. Usage is quite
straightforward, a simple *subscribe* call will result in getting the
periodic updates. Of course, don’t forget to *unsubscribe* (and finally,
disconnect the LocationClient) if necessary.

The next piece of code shows you how to wrap location-oriented code into
a subject:

    public class LocationProvider {

        protected final BehaviorSubject<Location> behaviorSubject;
        protected final LocationClient locationClient;

        public LocationProvider(final Context context) {
            final LocationRequest locationRequest = LocationRequest.create()
                .setInterval(30000)
                .setPriority(LocationRequest.PRIORITY_LOW_POWER);

            behaviorSubject = BehaviorSubject.createWithDefaultValue(null);
            behaviorSubject.subscribeOn(Schedulers.threadPoolForIO());

            locationClient = new LocationClient(context, new GooglePlayServicesClient.ConnectionCallbacks() {
                @Override
                public void onConnected(Bundle bundle) {
                    behaviorSubject.onNext(locationClient.getLastLocation());

                    locationClient.requestLocationUpdates(locationRequest, new LocationListener() {

                        @Override
                        public void onLocationChanged(Location location) {
                            behaviorSubject.onNext(location);
                        }

                    });
                }

                @Override
                public void onDisconnected() {
                    behaviorSubject.onCompleted();
                }

            }, new GooglePlayServicesClient.OnConnectionFailedListener() {
                @Override
                public void onConnectionFailed(ConnectionResult connectionResult) {
                    // propagate errors
                }
            }
            );

        }

        public void start() {
            if (!locationClient.isConnected() || !locationClient.isConnecting())
                locationClient.connect();
        }

        public void stop() {
            if (locationClient.isConnected())
                locationClient.disconnect();
        }

        public Observable<Location> subscribeToLocation() {
            return behaviorSubject;
        }

    }

Instantiate and start in the Application subclass:

    public class BaseApplication extends Application {

        public static final LocationProvider locationProvider;

        @Override
        public void onCreate() {
            super.onCreate();
            locationProvider = new LocationProvider(this);
            locationProvider.start();
        }
    }

Get updates when needed:

    BaseApplication.locationProvider.subscribeToLocation()
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Action1<Location>() {
                    @Override
                    public void call(Location location) {
                        System.out.println(location == null ? "empty" : location.toString());
                    }
                });

The example above is incomplete, make sure to implement error-handling
if used in production (check out [this
post](http://howrobotswork.wordpress.com/2013/11/18/rxjava-and-android-error-handling/)
on the subject) and to do an in-depth configuration of the
LocationRequest tailored to your specific needs. Protip: look into the
ConnectableObserver’s [refCount()
method](http://netflix.github.io/RxJava/javadoc/rx/observables/ConnectableObservable.html)
for implementing an auto-stop/start mechanism.

A short conclusion: subjects are awesome, they make working with
locationproviders and sensors a piece of cake.
