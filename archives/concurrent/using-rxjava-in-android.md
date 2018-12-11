Using RxJava with Android
=========================

If you’re into Android (and Java) development, there is a good chance
you’ve already heard about RxJava, which is a Java implementation of
Reactive Extensions developed by Netflix. Reactive Extensions is a
*library to compose asynchronous and event-based programs using
observable collections and LINQ-style query operators*, quoted from the
corresponding [MSDN
site](http://msdn.microsoft.com/en-us/data/gg577609.aspx). Netflix made
the library available for the public on Github, supporting Java 6 or
newer, making it available to use with Android apps as well.

This post is the first in a series about RxJava and Android. It is a
tutorial, which will show you how to build a REST API client in Android
with RxJava observables (and based on Square’s Retrofit).

Let’s start the example with adding the required libraries to your
project. If you’re using maven, just add the following dependencies to
the pom.xml:

    <dependency>
        <groupId>com.squareup.retrofit</groupId>
        <artifactId>retrofit</artifactId>
        <version>1.2.2</version>
    </dependency>
    <dependency>
        <groupId>com.netflix.rxjava</groupId>
        <artifactId>rxjava-android</artifactId>
        <version>0.14.6</version>
    </dependency>

In this post I use the [OpenWeatherMap
API](http://api.openweathermap.org/), which is a free weather data API.
It is quite easy to configure, just supply your location (the city name
or the geocoordinates) via a query param, see [this
example](http://api.openweathermap.org/data/2.5/weather?q=Budapest,hu).
By default it serialises into JSON (but you can switch to XML and HTML
as well) accurarcy and the temperature units can also be changed. See
more [here](http://api.openweathermap.org/API).

Usually implementing an api call requires the following steps (each with
it’s own amount of boilerplate code):

1.  creating the model classes (and supplying annotations if necessary)
2.  implementing the network layer for request / response management,
    with error handling
3.  writing the code that performs the call in a background thread
    (usually in some form of an AsyncTask), with a callback function
    capable of presenting the response on the UI thread

Creating the model classes
--------------------------

The first point can be (partially) automated using JSON-POJO generators
like [jsonschema2pojo](http://www.jsonschema2pojo.org/). The model class
for the OpenWeather API can be copied from this container.

    public class WeatherData {

        public Coordinates coord;
        public Local sys;
        public List<Weather> weathers;
        public String base;
        public Main main;
        public Wind wind;
        public Rain rain;
        public Cloud clouds;
        public long id;
        public long dt;
        public String name;
        public int cod;

        public static class Coordinates {
            public double lat;
            public double lon;
        }

        public static class Local {
            public String country;
            public long sunrise;
            public long sunset;
        }

        public static class Weather {
            public int id;
            public String main;
            public String description;
            public String icon;
        }

        public static class Main {
            public double temp;
            public double pressure;
            public double humidity;
            public double temp_min;
            public double temp_max;
            public double sea_level;
            public double grnd_level;
        }

        public static class Wind {
            public double speed;
            public double deg;
        }

        public static class Rain {
            public int threehourforecast;
        }

        public static class Cloud {
            public int all;
        }

    }

Networking with Retrofit
------------------------

The second point (implementing the network layer) requires a lot of
boilerplate code, however Square’s
[Retrofit](http://square.github.io/retrofit/) library solves these tasks
with only a few lines. You only have to create an interface (with
annotated parameters describing the request), then use the
RestAdapter.Builder to build the client. Retrofit also takes care of
JSON serialisation and deserialisation.

     private interface ApiManagerService {
        @GET("/weather")
        WeatherData getWeather(@Query("q") String place, @Query("units") String units);
    }

The HTTP annotation consists of the request method (in this example this
is GET, but you can also use POST, PUT, DELETE and HEAD with Retrofit)
and the relative url (the base url is supplied via the
RestAdapter.Builder). The *@Query* annotation concatenates queryparams
into the request; in this call we have a place (the name of the
location) and the measurement unit.

Let’s take a look at an actual API call (of course this must be
performed in a non-UI thread). The code is pretty self-explanatory:

    //...
    final RestAdapter restAdapter = new RestAdapter.Builder()
        .setServer("http://api.openweathermap.org/data/2.5")
        .build();

    final ApiManagerService apiManager = restAdapter.create(ApiManagerService.class);
    final WeatherData weatherData = apiManager.getWeather("Budapest,hu", "metric");
    //...

So that’s it, you just created a functioning API call with only a few
lines code, congrats! Again, Retrofit is much more powerful than this
basic sample; you can read more
[here](http://square.github.io/retrofit/).

Going reactive with RxJava
--------------------------

Now let’s jump into the third step: the RxJava-part! This example will
show you how to use it for managing async API calls, but this is only
one of many possible use-cases, RxJava is capable of much more. Quoted
from Netflix’s Github Wiki:

> RxJava is a Java VM implementation of Reactive Extensions: a library
> for composing asynchronous and event-based programs by using
> observable sequences.
>
> It extends the observer pattern to support sequences of data/events
> and adds operators that allow you to compose sequences together
> declaratively while abstracting away concerns about things like
> low-level threading, synchronization, thread-safety, concurrent data
> structures, and non-blocking I/O.
>
> It supports Java 5 or higher and JVM-based languages such as Groovy,
> Clojure, and Scala.

In this post I assume that you have a little knowledge about RxJava. If
that’s not true, I strongly recommend reading
[these](http://www.reactivemanifesto.org/)
[two](http://techblog.netflix.com/2013/02/rxjava-netflix-api.html)
articles and the first few pages of the [Netflix Github wiki
page](https://github.com/Netflix/RxJava/wiki) before continuing.

In the last part of this example you’ll extend the API manager with the
ability to emit observables, then use these to perform n simultaneous
calls to the same url with different queryparams.

First, replace the interface you created above with this class:

    public class ApiManager {

        private interface ApiManagerService {
            @GET("/weather")
            WeatherData getWeather(@Query("q") String place, @Query("units") String units);
        }

        private static final RestAdapter restAdapter = new RestAdapter.Builder()
            .setServer("http://api.openweathermap.org/data/2.5")
            .build();
        private static final ApiManagerService apiManager = restAdapter.create(ApiManagerService.class);

        public static Observable<WeatherData> getWeatherData(final String city) {
            return Observable.create(new Observable.OnSubscribeFunc<WeatherData>() {
                @Override
                public Subscription onSubscribe(Observer<? super WeatherData> observer) {
                    try {
                        observer.onNext(apiManager.getWeather(city, "metric"));
                        observer.onCompleted();
                    } catch (Exception e) {
                        observer.onError(e);
                    }

                    return Subscriptions.empty();
                }
            }).subscribeOn(Schedulers.threadPoolForIO());
        }

    }

Let’s take a look at the *getWeatherData()* method! It returns an
Observable, created by an *Observable.create()* call where you’ll have
to implement the
[Observable.OnSubscribeFunc](http://netflix.github.io/RxJava/javadoc/rx/Observable.OnSubscribeFunc.html)
interface. After subscribed to, the Observable begins work, emitting the
results as params in the *onNext()* function. Since we want these API
calls to run parallel, you only do one call in an observable, then
finishing with *onComplete()*. The *subscribeOn()* method is also
important, this decides what kind of thread to use. Call it with
*Schedulers.threadPoolForIO()* for IO- and network-bound work.

The last step is to perform the API calls. The following code performs
parallel async calls to the same base url with different query
parameters.

    Observable.from(cities)
                .mapMany(new Func1<String, Observable<WeatherData>>() {
                    @Override
                    public Observable<WeatherData> call(String s) {
                        return ApiManager.getWeatherData(s);
                    }
                })
                .subscribeOn(Schedulers.threadPoolForIO())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Action1<WeatherData>() {
                    @Override
                    public void call(WeatherData weatherData) {
                        // do your work
                    }
                });

An *Observable.from()* call on the array containing the city names
creates an observable which will emit the Strings in the array on
different threads. Then a *mapMany()* call will transform the emitted
Strings into observables; this is where the
*ApiManager.getWeatherData()* call occurs.

Again, subscribe on the I/O threadpool, but in Android, if you want to
display the results in the UI, you’ll have to post it on the UI thread,
because *only the original thread that created a view hierarchy can
touch its views*, as per the popular exception. This can easily be
achieved using the *observeOn()* method with
*AndroidSchedulers.mainThread()*. The *subscribe()* call triggers the
observable and it’s up to the user to define what to do with the result.

This example shows the versatility and robustness of RxJava. Without Rx,
you’d need to iterate through each address, creating a new thread,
making the API call and posting back to the UI thread on an async
callback. Rx allows you to do this with only a few lines of code, with
powerful functions to create, combine, filter and transform observables.

RxJava is a great way to utilize concurrency in Android apps, and
although it takes some time getting used to, right now I can’t think of
a better way of handling async calls. The *reactive extensions* library
is well thought-out, we’ve been using the RxJava implementation in
Android apps for a few weeks now (in the near future our
[startup](http://getinch.com/)‘s async tasks will be completely based on
it), and the more you dive into it, the more it will amaze you.
