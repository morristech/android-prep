
Monday, December 16, 2013
-------------------------

### Testing on Android (Part 1): Unit Tests

I've recently been doing research on Android testing.  I'm quite new to this business; automated testing has (for the longest time) felt unnecessary.  But I've been slowly convinced that the benefits outweigh the time costs - as long as you do it in an efficient manner.  To that end, I set out to evaluate the many, many Android testing frameworks to see which ones seemed to save the most time.
 I began by summarizing all the tools/services I could find in [a spreadsheet](http://goo.gl/XSUxoJ) (let me know if I'm missing anything).  Beyond that, I am going to do a series of posts going into more detail about different parts of Android testing:

-   **Part 1: **[Unit Tests](http://goo.gl/m6bXcJ)
-   **Part 2:** [Functional Tests](http://goo.gl/KXHZMg)
-   **Part 3:** [Other Testing Tools](http://goo.gl/X49RoP)
-   **Part 4:** [Testing Services](http://goo.gl/60Xnf7)
-   **Spreadsheet:** [Android Testing](http://goo.gl/XSUxoJ)

Let's start with unit testing.
 **Unit Tests**
 There's no reason you can't use normal JUnit 4 testing for Android applications... as long as you stay away from anything Android.
 Normally you compile against the SDK's android.jar, which contains nothing but stubbed methods that throw exceptions when run.  When you actually upload your APK to a device, it uses the device's implementations of all those stubs.  As a result, when running normal unit tests in your IDE, you get no access to those framework implementations (instead receiving mountains of exceptions).  This is not a big deal if you're testing some simple functionality that doesn't touch Android itself.

**Pros:**

-   Fast and easy

**Cons:**

-   Cannot use any Android framework classes

**The Android Testing Framework**
 [The Android testing framework](http://developer.android.com/tools/testing/testing_android.html) is the official method of unit testing on Android.  It loads your application onto a device, then runs JUnit-based test suites.  Since it runs on the actual OS you can use the Android framework as you normally would in your application and can conduct a series of realistic tests that way.
 Ostensibly the testing framework is unit testing, but the slowness of having to fully compile and upload your app onto a device before executing any tests makes testing slow.  Plus, you have to make sure you've got a device attached or an emulator running.  As a result, I might consider the testing framework for semi-regular tests (e.g., whenever you push a new commit, or nightly tests) but I would have trouble using them while actively developing.

**Pros:**

-   Access to the Android framework

**Cons:**

-   Slow
-   Requires attached device or running emulator
-   Uses JUnit 3 (instead of the newer JUnit 4)

**Robolectric**
 [Robolectric](http://robolectric.org/) is a project that unifies the speed of unit testing with the ability to access the Android framework.  It does this by implementing all those stubs with mocked classes.
 Having tried it out, it is lightning fast and works as expected.  I'm also impressed with the amount of active development on it - this is a rapidly improving framework.  However, the active development does take a toll; documentation is a bit lacking, plus some new versions of Robolectric break things in previous versions.  Plus, it can't mock everything - for example, inter-app communication - since it's not on an actual Android OS.  That said, the benefits here far outweigh the negatives when it comes to unit testing Android.

**Pros:**

-   Fast
-   Can access mocked Android framework
-   Actively developed

**Cons:**

-   Not the true Android framework
-   Not everything is mocked
-   Lacking documentation

**Conclusion**
 I'm a fan of what [Jason Sankey said on StackOverflow about tiered unit testing](http://stackoverflow.com/a/15020781/60261): Prefer pure unit tests, then Robolectric, then the Android testing framework.  The tests get harder/slower the higher the tier, but sometimes you need it.

Posted by [Daniel](http://www.blogger.com/profile/17003436808680466962 "author profile") at [9:00 AM](http://daniel-codes.blogspot.com/2013/12/testing-on-android-part-1-unit-tests.html "permanent link") [![](http://img1.blogblog.com/img/icon18_email.gif)](http://www.blogger.com/email-post.g?blogID=8001153144156969687&postID=1017742328373516959 "Email Post") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=8001153144156969687&postID=1017742328373516959&from=pencil "Edit Post")

Labels: [android](http://daniel-codes.blogspot.com/search/label/android), [testing](http://daniel-codes.blogspot.com/search/label/testing)

