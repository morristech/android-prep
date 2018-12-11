# Testing ALL the Android Image and http Libraries
I've been testing and benchmarking a bunch of the various image loading and http request libraries available, since a couple of them were released in the past week.

**Lineup:**

- AndroidAsync + UrlImageViewHelper (mine)
- Volley (Google)
- okhttp + Picasso (Square)
All support cached and conditionally cached responses, keep alive, etc.

**Thoughts:**

Picasso has the nicest image API. I am going to steal their currying API style for my future/current stuff. Picasso is also noticeably the slowest. Especially on 3g vs wifi. Probably due to their custom okhttp client.

UrlImageViewHelper + AndroidAsync is the fastest. Playing with these other two great libraries have really highlighted that the image API is quite dated, however.

Volley is slick; I really enjoy their pluggable backend transports, and may end up dropping AndroidAsync in there. The request priority and cancellation management is great.

>*Update*

>These aren't really http libs. Just image loaders. but there were requests for comparisons in the comments...

>Android-Universal-Image-Loader is the most popular one out there currently. Highly customizable.

>AQuery; like jquery, but for Android? I guess it's nice, if you're into that sort of thing. Don't use this one though; it craps on the UI thread or something. Loading a bunch of images on my Nexus 4 in a listview made it seem like I was back on my HTC G1 all over again. Major stuttering.

**Tests with caches clear:**

Cold is fresh app start.
Warm is caches clear with http connections presumably kept alive.

    Cold/Warm (in milliseconds, avg of 10 runs, clearing data every run):
    Picasso 12142/11892
    UrlImage 7378/4525
    Volley 8292/7520

>*Update*

>Android-Universal-Image-Loader 14484/11243
AQuery 11341/9637 (this one seems to lock up the UI thread... don't use it)
Here's the test code base:
[https://github.com/koush/AndroidNetworkBench](https://github.com/koush/AndroidNetworkBench)

**Conclusion:**
These tests are hardly conclusive. I just tested concurrent network access with many images. Admittedly, there's more to testing a library than that. I like how Volley plays nice with the Activity lifecycle, for example. None of the other libraries do that.
So, whatever floats your boat really. I want Volley with Picasso's API.
Though, I'd stay away from AQuery. I may be doing it wrong, but the defaults shouldn't allow you to do it wrong. Feel free to check my sample to see if I'm crazy.﻿
