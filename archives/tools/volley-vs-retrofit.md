Android Async HTTP Clients: Volley vs Retrofit
==============================================

Dec 9th, 2013

We recently released a new version of our mobile app for Android.
Although it was a huge improvement from previous installments in terms
of features, design, and usability, there was one nagging issue in the
back of our minds: speed. There are times when the app isn’t as snappy
as we’d like it to be. After some profiling, benchmarks, and common
sense, we determined that retrieving data from the API (the networking)
was the bottleneck.

The Old Way: AsyncTasks
-----------------------

As of the latest version, we use the built-in AsyncTasks to retrieve
data from Canvas’ servers. A quick Google search will explain the
numerous issues with our approach: no orientation-change support, no
ability to cancel network calls, as well as no easy way to make API
calls in parallel. With the exception of Froyo and Gingerbread,
AsyncTasks (by default) run in a serialized fashion. In a practical
sense, this means that only one AsyncTask is running at any given time.
Views that require multiple API calls (the DashBoard currently has 7)
run extremely slow; sometimes taking multiple seconds to load.

Introducing Volley and Retrofit
-------------------------------

Luckily, there are a few third party libraries that provide support for
concurrent background threads, network caching, as well as other
features that clean up networking code substantially. The first library
that we looked into was
[Volley](https://android.googlesource.com/platform/frameworks/volley/),
an open-source library written by Google. It’s currently used in AOSP
Android as well as most of Google’s first-party applications. The other
library we looked into was
[RetroFit](http://square.github.io/retrofit/), another open-source
library written by Square.

How We Decided
--------------

The decision to switch the architecture of our networking code was not
an easy one to make. The interface with the Canvas API is a substantial
part of our application. At the time of writing this blog post, the
Canvas for Android project has about 43,000 lines of actual code. Around
3,500 lines of that code are dedicated to interfacing with the Canvas
API (setting up API endpoints, etc). JSON parsing comprises of another
7,300 lines of code. That means that more than 25% of our code is
dedicated to retrieving/saving data from the Canvas API. That’s just
making the API calls and parsing the results. That doesn’t include any
AsyncTask code or caching, which we feel should be categorized as
networking code as well.

As you can see, if we were going to switch out our networking code, it
would have to be for *compelling* reasons as it’d be a huge refactor. In
order to decide if it was worth it, we did a lot of reading about both
Volley and Retrofit. We looked at forums, blogposts, example code; we
read as much as we could. We learned a lot, but we will try to summarize
it the best we can.

From outwards appearances, they are quite similar in usage. They both
allow you to provide a “callback”, which is an interface with two
methods that you must override: success and failure. One of the methods
will be called on the main thread at the completion of the asynchronous
network call. The big difference is in how you specify the API endpoint
and what you actually get back.

With Volley, you specify the **entire** endpoint dynamically (parameters
and all) at the time of making the API call. By default, Volley returns
a JSONObject or a JSONArray depending on the type of request.

Retrofit, on the other hand, has you set the base endpoint url for all
API calls, then it has you build static interfaces that specify
endpoints using Java *annotations*. You can cleanly and dynamically
substitute path-segments, POST/GET variables, etc. into the endpoint at
the time of making the API call. In order to make an API call with
RetroFit, you call a method on the interface, pass in any substitutions,
and it will return to you a java model object. By default, Retrofit does
the JSON parsing automatically using GSON (which is really, really fast)
although you can plug in your own JSON parser if you want. Even though
the setup is slightly different, the actual API calls are done in a
similar way.

In order to get some performance benchmarks, We wrote a sample
application where we could control/simulate real-world API calls that
Canvas for Android actually makes. It would also give me a little bit of
experience actually using the libraries. To start off with, we wrote a
very basic app that allowed me to toggle between an easy API with little
JSON parsing and a complex API with a long response. The total number of
API calls to make could be changed in the app as well. We also included
the exact suite of API calls that the Canvas for Android Dashboard makes
for a more real-world test. This benchmark showed me three things: 1)
they were both significantly easier to use than AsyncTasks, 2) they both
cleaned up the codebase, and 3) they were both a lot faster than what we
were currently doing. Obviously the benchmarks fluctuated based upon
network conditions; however, they consistently outperformed the way we
are currently doing our networking.

![](http://i.imgur.com/tIdZkl3.png)

In all three tests with varying repeats (1 – 25 times), Volley was
anywhere from 50% to 75% faster. Retrofit clocked in at an impressive
50% to 90% faster than the AsyncTasks, hitting the same endpoint the
same number of times. On the *Dashboard test suite*, this translated
into loading/parsing the data several seconds faster. That is a massive
real-world difference. In order to make the tests fair, the times for
AsyncTasks/Volley included the JSON parsing as Retrofit does it for you
automatically.

At this point, we wanted to switch our networking library for
performance reasons, but our decision had to take other criteria into
consideration. If we were going to spend time refactoring a quarter of
our code base, we would have to be a little bit picky. Some of the
things we took into account were speed, ease of integration, code
cleanup, scalability, and time required to write new API calls.

RetroFit Wins
-------------

In the end, we decided to go with Retrofit for our application. Not only
is it ridiculously fast, but it meshes quite well with our existing
architecture. We were able to make a parent *Callback Interface* that
automatically handles the error function, caching, and pagination with
little to no effort for our APIs. In order to merge in Retrofit, we have
to rename our variables to make our models GSON compliant, write a few
simple interfaces, delete functions from the old API, and modify our
fragments to not use AsyncTasks. Now that we have a few fragments
completely converted, it’s pretty painless. There were some growing
pains and issues that we had to overcome, but overall it went smoothly.
In the beginning, we ran into a few technical issues/bugs, but Square
has a fantastic [Google+ community](https://plus.google.com/communities/109244258569782858265)
that was able to help us through it. We have successfully converted our
entire app to Retrofit. A build that’s running solely retrofit can be
expected in the Play Store in the coming weeks.

Feel free to ask questions in the comments if you have any.

Resources:
----------

### Retrofit:

-   [Source and Samples](https://github.com/square/retrofit) (Source and samples)
-   [Square Homepage](http://square.github.io/retrofit/)
-   [Square Google+ Community](https://plus.google.com/u/0/communities/109244258569782858265)

### Volley:

-   [Source](https://android.googlesource.com/platform/frameworks/volley/)
-   [Demonstration](https://developers.google.com/live/shows/474338138)
-   [Github of Examples](https://github.com/ogrebgr/android_volley_examples)
-   [Usage Example](http://www.technotalkative.com/android-volley-library-example)

Posted by Josh Ruesch Dec 9th, 2013