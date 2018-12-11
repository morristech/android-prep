10 Feb 2014 on android | testing

Testing on Android (Part 4): Testing Services
=============================================

The final part of my Android testing series will be about services one can use for testing. By services, I typically mean companies you pay to help you do your testing. I'm currently operating on a budget of zero, so I haven't actually tested any of these services at all, but I felt it was still worth summarizing my findings.

- Part 1: [Unit Tests](http://goo.gl/m6bXcJ)
- Part 2: [Functional Tests](http://goo.gl/KXHZMg)
- Part 3: [Other Testing Tools](http://goo.gl/X49RoP)
- Part 4: [Testing Services](http://goo.gl/60Xnf7)
- Spreadsheet: [Android Testing](http://goo.gl/XSUxoJ)

Running Tests For You
---------------------

There are some services out there that simply support other frameworks I've talked about earlier. In particular, some services (like [AppThwack](https://appthwack.com/)) offer the ability to just run your tests on their own farm of devices. If I had any budget for automation I might consider these services because they'd save me from having to setup my own device farm.

Examples: [Apkudo](https://www.apkudo.com/), [AppThwack](https://appthwack.com/), [DeviceAnywhere](http://www.deviceanywhere.com/), [LessPainful](https://www.lesspainful.com/), [Sauce](https://saucelabs.com/)

Recorder-based Testing
----------------------

This seems like a rather popular setup: you can setup a service's software to record yourself running through your application. Then you can replay the session later with assertions that you've added. Personally I like getting my hands dirty with code so I'd skip this but maybe it appeals to you.

Examples: [DroidPilot](http://droidpilot.cn/en), [Experitest](http://experitest.com/), [Jamo Solutions](http://www.jamosolutions.com/), [PerfectoMobile](http://www.perfectomobile.com/), [Ranorex](http://www.ranorex.com/), [Testdroid](http://bitbar.com/), [TestObject](http://testobject.com/)

Crowd-Sourced Testing
---------------------

This is not really an automated testing service so much as manual testing on a grand scale. Your app is passed out to a bunch of random people around the world to try out for some amount of time. It won't replace a skilled QA worker with a thoughtful test plan, but it is not bad for finding issues with random devices you might not have on hand (or with translations that might have gone awry).

Of course, you might consider your users to be the ultimate form of crowd-sourced testing... but usually with these services you get actual bug report responses, rather than mysteriously bad ratings.

Examples: [TestFairy](http://www.testfairy.com/), [The Beta Family](http://thebetafamily.com/), [UserTesting](http://www.usertesting.com/mobile), [uTest](http://www.utest.com/)

A/B Testing
-----------

This is also not really an automated test, but worth mentioning because I found a few frameworks. If you're interested in A/B testing there are a few companies out there exploring the space already.

Examples: [Apptimize](http://apptimize.com/), [Arise](http://arise.io/), [LeanPlum](https://www.leanplum.com/), [Vessel](https://www.vessel.io/)

#### [Dan Lew](http://blog.danlew.net/about/)

[Subscribe!](http://blog.danlew.net/rss/)

All content copyright [Dan Lew Codes](http://blog.danlew.net/) © 2014 • All rights reserved.

Proudly published with [Ghost](http://ghost.org)
