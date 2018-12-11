Monday, January 6, 2014
-----------------------

### Testing on Android (Part 2): Functional Tests

Here's part two of my series on Android testing.  This time, I'm going to wade into the huge number of functional testing frameworks that exist.  The differentiation I made between unit testing and functional testing is that the functional tests operate the actual device (as in, you could watch it running through a test).

-   **Part 1:** [Unit Tests](http://goo.gl/m6bXcJ)
-   **Part 2:** [Functional Tests](http://goo.gl/KXHZMg)
-   **Part 3:** [Other Testing Tools](http://goo.gl/X49RoP)
-   **Part 4:** [Testing Services](http://goo.gl/60Xnf7)
-   **Spreadsheet:** [Android Testing](http://goo.gl/XSUxoJ)

**So Many Frameworks**

As you can see in [my spreadsheet](http://goo.gl/XSUxoJ), there are a ton of functional testing frameworks out there.  I don't have any inclination to test all of them.  Here's what I haven't tried myself, for various reasons:

-   **Non-Java** - if my code and unit tests are going to be in Java, I might as well make my functional tests in Java as well.
-   **Recorder-based testing** - While this might be good for a less technical tester, I'd prefer exact control over my tests.
-   **Superseded or discontinued** - Some frameworks are old and have been surpassed by more modern frameworks.  Others have been discontinued.

This leaves just a few frameworks to investigate.

**Robotium**

 I was already somewhat familiar with [Robotium](https://code.google.com/p/robotium/).  It runs off of the official Android testing framework, but adds the capabilities needed to actually run through an entire app.
 It's been around for years, and so it's fairly stable.  It's also straightforward; you use the Solo class to run through your app, one step at a time.  It requires compiling along with the app's source, which could be a negative for some.  Overall, it's a solid functional testing solution.

**uiautomator**

 [UiAutomator](http://developer.android.com/tools/help/uiautomator/) is a more recent offering from Google.  I found it to be lacking and difficult to use.
 First, it depends on more recent APIs, so it can only be used on Jelly Bean and above - you can't use it to test backwards compatibility.  Second, the deployment is more complex than other frameworks.  There's no simple script to put the code you wrote onto a device - you have to write a script yourself because it involves a few dynamic commands (depending on how you named your classes).
 Third, it just feels like it's not quite there.  For example, simply launching my app from the test was a struggle.  The suggested start is to begin on your home page then page towards your app to launch it, except the code for doing so is broken.  Instead I had to use some hacky code which used "am start" to launch my Activity.
 It does have a few unique advantages.  First, it can be written entirely black-box; you don't need access to the source code.  You use uiautomatorviewer to examine how an app is written and write tests based on that.  Second, it runs on the entire OS, so you can really test cross-app interaction.  If you need either of these, then I might check it out; but for my purposes this is a non-starter.

**Espresso**

 [Espresso](https://code.google.com/p/android-test-kit/) is the latest toolkit from Google, and it's so awesome I have to wonder if the reason uiautomator is having issues is because everyone was actually working on Espresso.
 It's got a different paradigm from other testing frameworks.  It starts with onView() or onData() with Hamcrest matchers to find your View/AdapterView.  Once found, you can then either perform an action or check some assertions.
 The reason for the onView()/onData() setup is that Espresso examines the UI thread to know when processing is done.  A common problem with functional testing on Android is not knowing when a View will show up, so you end up with a lot of sleeps in your tests.  With Espresso you skip all of that, so it's blazing fast!
 It's not all sunshine and roses.  It doesn't handle animations well (in fact, the expected setup is to turn all your animations off with dev opts).  I also found initial understanding harder, having to learn how to use Hamcrest to match my Views.  But once I got past those, the testing was so fast and stable that it blew me away.

**Appium**

 I had started to try out Appium, as it seemed to present another way of functional testing, but ultimately gave up.
 Maybe it was because I tried uiautomator, robotium, and Espresso before getting to Appium, but the setup was just overwhelming.  There was no "hello, world" sample I found that could take me from zero to testing.  There was a lot of documentation I found that listed out about five things I had to install on my machine (and have play together nicely) before I could start.
 If my entire job was automation testing, or I knew selenium very well already, then I might consider Appium because then the time investment might pay off.  But as an Android developer who wants to dabble with testing on the side, I don't want to have to deal with getting this environment setup (not to mention the pain I'd be putting others through to replicate my work).

**Conclusion**

I would take my thoughts with a grain of salt; I haven't used any of these long enough to really get into the nitty gritty.  That said, I think my future functional tests will be written in Espresso; its design paradigm makes for focused, solid testing.  Plus, its basis on the Looper to determine when to continue makes it lightyears faster than the other frameworks could hope to be.  I hope it continues to be supported by Google because I like it.

Posted by [Daniel](http://www.blogger.com/profile/17003436808680466962 "author profile") at [8:30 AM](http://daniel-codes.blogspot.com/2014/01/testing-on-android-part-2-functional.html "permanent link") [![](http://img1.blogblog.com/img/icon18_email.gif)](http://www.blogger.com/email-post.g?blogID=8001153144156969687&postID=2134425571270378568 "Email Post") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=8001153144156969687&postID=2134425571270378568&from=pencil "Edit Post")

Labels: [android](http://daniel-codes.blogspot.com/search/label/android), [testing](http://daniel-codes.blogspot.com/search/label/testing)