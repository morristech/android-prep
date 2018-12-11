[![The Nerd Blog logo](http://36stpl737qv11acqekvsggfk3.wpengine.netdna-cdn.com/wp-content/themes/bignerdranch2/images/the-nerd-blog-logo.png)](http://blog.bignerdranch.com)

Apr 25 2013

Testing the Android way
=======================

![Josh Skeen](http://36stpl737qv11acqekvsggfk3.wpengine.netdna-cdn.com/wp-content/uploads/2013/01/Josh-40x40.jpg)

**Author:
 [Josh Skeen](http://blog.bignerdranch.com/author/josh/)**

As a Rails developer, I learned [the benefits of a test-driven style](http://bit.ly/XTy2CR), and I never want to go back to the old style of writing code that might work, but might not! So when I decided to learn Android programming, finding the right strategies and tools to drive tests was the first task at hand. I found several excellent libraries that help facilitate a test-driven workflow on Android, and a test culture that is rapidly adopting the use of automated testing.

### Robolectric

The largest barrier when getting started on this challenge was the dependency of the Android core libraries themselves upon the actual Android operating system. The [AndroidTestCase](http://developer.android.com/reference/android/test/AndroidTestCase.html) classes provided by Google, for example, need a new instance of an emulator to run. This emulator then needs a new instance of the APK under test on it. The whole cycle of spinning up the emulator, deploying the APK and running the actual test could take a few minutes upon every run of the suite to get set up—a major time sink.

These slow tests were a dealbreaker, and I felt it would likely reduce the chances we’d actively use the tests. Fortunately for us, the [Robolectric Project](http://pivotal.github.io/robolectric/) from Pivotal Labs has done the hard work of removing this dependency.

Effectively, **Robolectric** replaces the behavior of code that would otherwise require an emulator or actual device with its own, and once it’s set up, we can write jUnit-style tests against our classes without needing the baggage of the emulator. It does this using so-called “**Shadow Classes**,” mock implementations of Android core libraries.

**Robolectric** also goes further than this, enabling you to provide your own custom behavior for these shadow classes. This is extremely helpful for custom test behavior you may need. For example, my current project depends upon loading large sets of data to the SQLite database managed by Android. Using the “**Shadow Class**” notion, **Robolectric** allowed me to implement a ‘test fixture’ style database reset, where any changes that may have happened to a default set of data I provide gets reset to ensure that I can assert results dependent upon this data. Here’s what I mean:

    public class MyTestRunner extends RobolectricTestRunner{
      @Override
      public void beforeTest(Method method) {
        super.beforeTest(method);
        // swaps in custom implementations of the sqlite android database class.
        Robolectric.bindShadowClass(MyShadowSQLiteDatabase.class);
      }
    }

The **MyShadowSQLiteDatabase** implementation provides custom behavior that points to our custom test database. Without Robolectric, we would be dependent upon the core Android class behavior. Within the ShadowSQLiteDatabase class, we now change how Android’s core behavior would normally work:

    @Implements(SQLiteDatabase.class) //this annotation indicates to android what implementation this class is providing
    public class MyShadowSQLiteDatabase extends ShadowSQLiteDatabase{
        @Implementation
        public static SQLiteDatabase openDatabase(String path, SQLiteDatabase.CursorFactory factory, int flags){
            try {
                //Replace Robolectric's in-memory only connection with a real sqlite database connection.
                connection = DriverManager.getConnection("jdbc:sqlite:" + path); 
            } catch (SQLException e) {
                e.printStackTrace();
            } 
            return newInstanceOf(SQLiteDatabase.class); //an instance of the sqlite-jdbc sqliitedatabase class
        }

    }

And then in the test itself we can finally use this new behavior:

    @RunWith(MyTestRunner.class)
    public class TestDatabaseStuff extends BaseTest{

      public static final String TEST_DATABASE = "test/fixtures/test_database.s3db";
      public static final String ORIG_DATABASE = "test/fixtures/test_database.orig";

      @Before
      public void setup() throws IOException{
        //reset the test fixture
        originalDatabase = new File(ORIG_DATABASE);
        fileToWrite = new File(TEST_DATABASE);
        FileUtils.copyFile(originalDatabase, fileToWrite); //resets the test database with a new copy
      }
    }

### Syntactic Sugar

I had a way to run tests quickly, but I then began to look for ways to write tests faster and more cleanly.

#### Fest for Android

The first discovery was [Fest-Android](http://square.github.io/fest-android/), a library extension for the [FEST framework](http://fest.easytesting.org/) from the fine folks at Square Labs. Fest-Android is a great improvement upon the regular jUnit-style assertions. It gives a chainable (or “fluent”) syntax for checking assertions, and makes tests easier to write (and read!). A bonus of this is that any decent Java IDE can code-complete the available assertions for any property, cleaning up the confusion with the “expected” and “actual” syntax in the jUnit-style test syntax.

For example:

    //regular junit:
    assertEquals(View.GONE, view.getVisibility());
    //fest!
    assertThat(view).isGone();

At the point **assertThat(view)** is called, the IDE can then give intelligent feedback about the types of assertions available.

### Mockito = rspec-mocks… Sort of

For more complicated classes, replacing elaborate functionality coupled to other classes in order to isolate tests is done using the notion of ‘mocks’. The [Mockito](https://code.google.com/p/mockito/) framework for Java does this well. An example from a project was to selectively change the behavior of a method to return a timestamp I could test against, rather than a dynamically generated one. Mockito made this a snap:

`Mockito.doReturn((long) 1363027600).when(myQueryObject).getCurrentTime();`

Whenever **myQueryObject.getCurrentTime** is called, a predefined value is returned instead of the current one. This is very useful for having classes return results you can actually test!

### Robotium = Integration Tests

Sometimes, unit tests alone fail to address behavior you will want to check with your tests. For example, let’s say I want to assert that entering a valid username and password, clicking the login button, and then clicking on the account details button takes me to the right view within my application. A unit test doesn’t really capture this “path” through the application, and is better described using an “integration test,” or a test that checks whether multiple components of the system work properly in conjunction with one another. For this type of work, I found [Robotium](https://code.google.com/p/robotium/), which uses a Selenium-like style to run the test from the UI. This of course requires an emulator or device to work. I found that keeping the unit test projects and integration test projects separate was a good compromise between the fast Robolectric tests, and the sometimes-necessary Robotium tests to check overall behavior across the system.

### Dependency Injection

To reduce the amount of effort required to set up classes for tests, the use of dependency injection is a huge win. Simply put, it allows you to configure the instantiation of classes across your application without manually doing so. It also allows the configuration of special behavior for classes without writing code from scratch. [Roboguice](https://github.com/roboguice/roboguice) brings the Google GUICE injection framework to Android, and makes it possible to use dependency injection throughout your Android app. Check out the [Roboguice wiki](https://github.com/roboguice/roboguice/wiki) on how to use this great tool.

### Wrapping up

While test-driven development isn’t as common in the Android community as it is with Rails, it seems that doing things the TDD way is gaining momentum. I hope this post helped to give a good overview of some of the tools that will help you test your Android project. Don’t hesitate to ask any questions, or point out any other tools I should know about below.
