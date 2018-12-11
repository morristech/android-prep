23 Jan 2014 on android | testing

Testing on Android (Part 3): Other Testing Tools
================================================

Part three of my Android testing series will be about odds-and-ends tools for testing that don't really fit into strict unit/functional testing frameworks, but are worth checking out.

- Part 1: [Unit Tests](http://goo.gl/m6bXcJ)
- Part 2: [Functional Tests](http://goo.gl/KXHZMg)
- Part 3: [Other Testing Tools](http://goo.gl/X49RoP)
- Part 4: [Testing Services](http://goo.gl/60Xnf7)
- Spreadsheet: [Android Testing](http://goo.gl/XSUxoJ)

monkey
------

Android's built-in tool [monkey](http://developer.android.com/tools/help/monkey.html) (not to be confused with mostly unrelated [monkeyrunner](http://developer.android.com/tools/help/monkeyrunner_concepts.html)) runs randomized stress tests on your application. You launch it against your application and it just sends random input events to your app. That's it!

I find its value to be limited because it just won't get far in any sort of application that requires intelligent user input. For example, a login screen would be quite difficult for monkey to defeat. You can use [ActivityManager.isUserAMonkey()](http://developer.android.com/reference/android/app/ActivityManager.html#isUserAMonkey()) to smooth out some of these kinks, but overall I think the value of the tool is in its low cost for usage.

Spoon
-----

[Spoon](http://square.github.io/spoon/) is a meta testing tool from Square that allows you to run tests in parallel on multiple devices at once. Not only that, but it collates the results into some nice output. Since testing on a variety of devices is key on Android, this tool is necessary for any serious testing.

It runs off of the normal Android testing framework (which means it's compatible with any framework also based on it, like Espresso). I found it extremely easy to setup and use for the first time. I highly recommend checking it out.

Mockito
-------

[Mockito](https://code.google.com/p/mockito/) is a Java library for mocking objects. You mock an object when you want it to act a certain way. It's compatible with Android and there are a lot of good places where it makes sense to use it. You can use it to mock system calls that might otherwise not work on Robolectric. You can use it to mock network calls that you want to act in a consistent manner while testing. It's a handy tool that assists with testing.

FEST Android
------------

[FEST Android](https://github.com/square/fest-android) is a version of FEST that is designed specifically for Android. FEST itself aims to be a more intuitive way to make assertions; FEST Android streamlines common tests that one might make with FEST for Android. If you like FEST, I think this makes a lot of sense, because it adds common methods you might want for many of the built-in Android tools - for example, checking if an ImageView has a particular Drawable in it.

#### [Dan Lew](http://blog.danlew.net/about/)

[Subscribe!](http://blog.danlew.net/rss/)

All content copyright [Dan Lew Codes](http://blog.danlew.net/) © 2014 • All rights reserved.

Proudly published with [Ghost](http://ghost.org)
