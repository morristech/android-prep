
Android application testing with the Android test framework - Tutorial
----------------------------------------------------------------------

### Lars Vogel

Version 1.6

Copyright © 2011, 2012, 2013 Lars Vogel

28.10.2013

**Android Testing**

This tutorial describes how to test Android applications with different Android testing frameworks.

* * * * *

1. Android automated testing
----------------------------

### 1.1. Android test strategy

Automated testing of Android applications is especially important because of the huge variety of available devices. As it is not possible to test Android application on all possible device configurations, it is common practice to run Android test on typical device configurations.

Having a reasonable test coverage for your Android application helps you to enhance and maintain the Android application.

### 1.2. How to test Android applications

Android testing is based on JUnit. Testing for Android can be classified into tests which require only the JVM and tests which require the Android system.

![Android testing categories](http://www.vogella.com/tutorials/AndroidTesting/images/xandroidtestcategories10.png.pagespeed.ic.kdZY1Na5cb.png)

Which tests require an Android system is explained later in this book. If possible, you should prefer to run your unit tests directly on the JVM as the test execution is much faster compared to the time required to deploy and run the test on an Android device.

### Note

The application which is tested is typically called the *application under test*.

### 1.3. Unit tests vs functional tests on Android

A *unit test* tests only the functionality of a certain component.

Let's, for example, assume a button in an Android activity is used to start another activity. A unit test would determine if the corresponding intent was issued, not if the second activity was started. A functional test would also check if the activity was correctly started.

### 1.4. JUnit 3

Currently the Android testing API supports JUnit 3 and not JUnit 4.

JUnit 3 requires that your test classes inherit from the JUnit 3 `junit.framework.TestCase` class.

In JUnit 3 test methods must start with the `test` prefix. The setup method must be called `setUp()` and the final clean up method must be called `tearDown()`.

### 1.5. What to test on Android applications

The following tables lists the access you should test in Android applications.

**Table 1. Areas to test**

|Test area|Description|
|:--------|:----------|
|Activity life cycle events|You should test if you activity handles the Android life cycle events correctly. You should also test if the configuration change events are handled well and if instance state of your user interface components is restored.|
|File system and database operations|Write and read access from and to the file system should be tested including the handling of databases.|
|Different device configurations|You should also test if your application behaves well on different device configurations.|

### 1.6. Testing preconditions

It is good practice in Android testing to have one method called `testPreconditions()` which tests the pre-conditions for all other tests. If this method fails, you know immediately that the assumptions for the other tests have been violated.

### 1.7. User interface tests

Android allows that only the main thread modifies the user interface. If a tests should run in the main thread you can annotate him with the `@UIThreadTest` annotation. These tests cannot be used to control the life cycle of components as they are executed in the same thread on the application under tests. If you have such tests and need to modify the user interface you have to use the `Activity.runOnUiThread(Runnable)` method.

### 1.8. Running tests on a server without display

To run tests without a display (headless), specify the adb *`-no-window`* parameter.

2. Which tests require an Android system to run?
------------------------------------------------

### 2.1. Testing standard Java classes

If your classes do not call the Android API, you can use the *JUnit* test framework without any restrictions.

The advantages of the method is that you can use any Java unit testing framework and utility as well as that the execution speed of the unit test is very fast compared to tests which require the Android system.

### 2.2. Testing Java classes which use the Android API

If you want to test code which use the Android API, you need to run these tests on an Android device. Unfortunately, this makes the execution of tests take longer.

This is because `android.jar` JAR file does not contain the Android framework code, but only stubs for the type signatures, methods, types, etc. The `android.jar` JAR file is only used for the Java compiler before deployment on an Android device. It is not bundled with your application. Once your application is deployed on the device, it will use the `android.jar` JAR file on the Android device. Calling methods from the `android.jar` JAR file throw a new `RuntimeException("Stub!")`.

This makes it impossible to test the Android framework classes directly on the JVM without additional libraries.

3. Android test projects and running tests
------------------------------------------

### 3.1. Android test projects

The preferred way of organizing tests is to keep them in separate Android test projects or source folders. The Android tooling for Eclipse emphasizes the usage of separate projects.

Instead of Android components, an Android test application contains one or more test classes.

The project under test must be added as dependency to the test project. The `AndroidManifest.xml` file must also specify that the test project uses the `android.test.runner` library and specifies the test runner for the unit test.

A test project also specifies the package of the application to test in the `AndroidManifest.xml` file under the *`android:targetPackage`* attribute. The following listing shows an example `AndroidManifest.xml` for a test project.

``` {.programlisting}
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="de.vogella.android.test.target.test"
      android:versionCode="1"
      android:versionName="1.0">
    <uses-sdk android:minSdkVersion="8" />
    <instrumentation 
        android:targetPackage="de.vogella.android.test.target" 
        android:name="android.test.InstrumentationTestRunner" />
    <application android:icon="@drawable/icon" android:label="@string/app_name">

    <uses-library android:name="android.test.runner" />
    </application>
</manifest> 
```

### 3.2. Creating a test project

The Android Developer Tools (ADT) provide support for the creation of Android test projects via a project creation wizard. This wizard can be reached under File → New → Other... → Android → Android Test Project.

### Note

It is good practice to use the name of the project under test and add *Test* or *.test* to it. We use the *.test* notation to have the project name stay the same as the package name.

The wizard creates the required dependencies and entries in the `AndroidManifest.xml` file automatically.

### 3.3. Running tests

To start an test from Eclipse, right-click on the test class and select Run As → Android JUnit Test.

On the command line you can start tests via the `ant test` command. This requires that you created the `build.xml` file for the test project with the `android update test-project` command.

``` {.programlisting}
# -p path to the test project
# -m path to the project under test

android update test-project -p . -m ../com.vogella.android.test.simpleactivity 

# Afterwards run the tests
ant test 
```

4. Mocking objects
------------------

Android provides mock classes for the Android framework in the `android.test` and `android.test.mock` packages. These mock classes allow you to isolate tests from a running system by stubbing out or overriding normal operations.

The following lists the most important mock objects which can be used for Android testing.

-   MockApplication

-   MockContext

-   MockResources

-   MockContentProvider

-   MockContentResolver

-   MockPackageManager

All methods on these mock objects throws exceptions. If requried you can extend these mocks and override the required methods.

5. Mocking the context
----------------------

You can use `MockContext` as `Context`.

The `RenamingDelegatingContext` class delegates calls to a given context and supports database and file operations by adding a prefix to all file names. This way you can test your components without affecting the database of the file system on your Android device.

6. Application testing
----------------------

The application class contains the logic, data and settings which are relevant for the whole application. Therefore you should test this object, to ensure it works correctly.

To test an Android application object you use the `ApplicationTestCase` class.

### Note

The test runner of of Android tests (`InstrumentationTestRunner`) creates automatically an instance of application during its initialization phase. If you do asynchronous processing in your `onCreate` method you should consider that.

7. Service testing
------------------

To test a service you use the `ServiceTestCase` class. It provides the `startService()` and `bindService()` methods to interact with the service. The `bindService()` immediately returns an `IBinder` object without callback. You also only need to provide an intent as input.

Testing asynchronous processing in services is a challenge as the duration of this processing may vary.

It is good practice to test if the service handles multiple calls from `startService()` correctly. Only the first call of `startService()` triggers the `onCreate()` of the service, but all calls trigger a call to `onStartCommand()` of the service.

8. Content provider testing
---------------------------

To test a content provider, you use the `ProviderTestCase2` class. `ProviderTestCase2` automatically instantiates the *provider* under test and inserts an `IsolatedContext` object which is isolated from the Android system, but still allows file and database access.

The usage of the `IsolatedContext` object ensures that your *provider* test does not affect the real device.

`ProviderTestCase2` also provides access to a `MockContentResolver` via the `getMockCOnktentResolver()` method.

You should test all operations of the *provider* and also what happens if the *provider* is called with an invalid URI or with an invalid projection.

9. Loader testing
-----------------

To test a *loader*, you use the `LoaderTestCase` class.

10. Test hooks into the Android framework
-----------------------------------------

### 10.1. Instrumentation

The Android testing API provides hooks into the Android component and application life cycle. These hooks are called the `instrumentation API` and allow your tests to control the life cycle and user interaction events.

Under normal circumstances your application can only react to the life cycle and user interaction events. For example if Android creates your activity the `onCreate()` method is called on your activity. Or the user presses a button or a key and your corresponding code is called. Via instrumentation you can control these events via your tests.

Only an instrumentation-based test class allows you to send key events (or touch events) to the application under test.

For example, your test can call the `getActivity()` method which starts an activity and returns the activity under test. Afterwards, you can call the `finish()` method, followed by a `getActivity()` method call again and you can test if the application restored its state correctly.

The Android instrumentation API allows you to run the test project and the normal Android project in the same process so that the test project can call methods of the Android project directly.

### 10.2. How the Android system executes tests

The `InstrumentationTestRunner` is the base test runner for Android tests. This test runner starts and loads the test methods. Via the instrumentation API it communicates with the Android system. If you start a test for an Android application, the Android system kills any process of the application under test and then loads a new instance. It does not start the application, this is the responsibility of the test methods. The test method controls the life cycle of the components of the application.

The test runner also calls the `onCreate()` method of the application and activity under test during its initialization.

11. Activity testing
--------------------

### 11.1. Life cycle of activities and instrumentation

As you use instrumentation to test activities, its life cycle methods are not called automatically, only its `onCreate()` method is called if you call the `startActivity()` method. You can call the other methods directly via the `getInstrumentation().callActivityOn*` helper methods.

### 11.2. Unit tests for activities

To test an activity in isolation, you can use the `ActivityUnitTestCase` class.

This class allows you to check the layout of the activity and to check if *intents* are triggered as planned. The *intent* is not sent to the Android system, but you can use the `getStartedActivityIntent()` method to access a potential intent and validate its data.

`ActivityUnitTestCase` starts the activity in an `IsolatedContext`, i.e., mainly isolated from the Android system.

`ActivityUnitTestCase` can be used to test layouts and isolated methods in the activity .

As this test runs in an `IsolatedContext`, the test must start the activity , i.e., it is not auto-started by the Android system.

``` {.programlisting}
Intent intent = new Intent(getInstrumentation().getTargetContext(),
        MainActivity.class);
startActivity(intent, null, null);

// after this call you can get the
// Activity with getActivity() 
```

### 11.3. Integration tests for activities

Functional tests for an activity can be written with the `ActivityInstrumentationTestCase2` class. This test uses the full Android system infrastructure and allows you to interact with different components. The communication with the Android infrastructure is done via the `Instrumentation` class which can be accessed via the `getInstrumentation()` method. This class allows you to send keyboard and click events.

### Warning

If you use this test case, the real infrastructure of Android is used. A call to `getApplication()` returns the same application instance across tests. If that is not desired you need to manually reset application state before a test.

If you prefer to set values directly, you need to use the `runOnUiThread()` of the activity. If all statements in your method interact with the UI thread, you can also use the `@UiThreadTest` annotation on the method. In this case you are not allowed to use methods which do not run in the main UI thread.

A test based on `ActivityInstrumentationTestCase2` starts the activity in the standard Android context, similar as if a user would start the application.

If you want to send key events via your test, you have to turn off the touch mode in the emulator via `setActivityInitialTouchMode(false)` in your `setup()` method of the test.

### 11.4. Testing the initial state

It is good practice to test the initial state of the application before the main activity start to be sure that the test conditions for the activity are fulfilled.

### 11.5. State management tests

You should write tests which verify that the state of an activity remains even if it is paused or terminated by the Android system.

The `ActivityInstrumentationTestCase2` class uses the `Instrumentation` class, which allows you to call the life cycle hooks of the activities directly. For example you can call the `onPause()` and `onDestroy()` method, followed by an `onCreate()` to validate that the state

12. Exercise: unit test for an activity
---------------------------------------

### 12.1. Create project which is tested

Create a new Android project called *com.vogella.android.test.simpleactivity* with the activity called *MainActivity*.

Add a second activity called `SecondActivity` to your project. This activity should use a layout with at least one `TextView`. The id of the `TextView` should be "resultText" and its text should be set to "Started".

Add an `EditText` field to the layout of the `MainActivity` class.

Add a button to the layout used by *MainActivity*. If this button is clicked, the second activity should be started.

Put the text `EditText` field as extra into the intent using "text" as key. Also put the "http://www.vogella.com" String as extra into the intent and use the key "URL" for this.

Here is some example code for the `MainActivity`.

``` {.programlisting}
package com.vogella.android.test.simpleactivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
  }

  public void onClick(View view) {
    Intent intent = new Intent(this, SecondActivity.class);
    intent.putExtra("URL", "http://www.vogella.com");
    startActivity(intent);
  }
} 
```

### 12.2. Create test project and class

Create a new test project called *com.vogella.android.test.simpleactivity.test*. Select *com.vogella.android.test.simpleactivity* as the project to test.

![Create test project wizard](http://www.vogella.com/tutorials/AndroidTesting/images/xcreateactivityunittest10.png.pagespeed.ic.M-e00Jx7at.png)

![Create test project wizard](http://www.vogella.com/tutorials/AndroidTesting/images/xcreateactivityunittest20.png.pagespeed.ic.o42pT2ERsP.png)

Create a test class called *MainActivityUnitTest* based on the superclass `android.test.ActivityUnitTestCase`. This class is used for the tests.

Initialize the activity in the setup method. The class should look like the following template.

``` {.programlisting}
package com.vogella.android.test.simpleactivity.test;

import android.content.Intent;
import android.test.TouchUtils;
import android.test.suitebuilder.annotation.SmallTest;
import android.widget.Button;

import com.vogella.android.test.simpleactivity.MainActivity;

public class MainActivityUnitTest extends
    android.test.ActivityUnitTestCase<MainActivity> {

  private int buttonId;
  private MainActivity activity;

  public MainActivityUnitTest() {
    super(MainActivity.class);
  }

  @Override
  protected void setUp() throws Exception {
    super.setUp();
    Intent intent = new Intent(getInstrumentation().getTargetContext(),
        MainActivity.class);
    startActivity(intent, null, null);
    activity = getActivity();
  }

} 
```

### 12.3. Write tests

Write a unit test for the activity which tests the following:

-   Check that the layout of the MainActivity contains a button with the `R.id.button1` ID

-   Ensure that the text on the button is "Start"

-   Ensure that if the getActivity.onClick() method is called, that the correct intent is triggered via the `getStartedActivityIntent()` method

### 12.4. Validate

Your test code should look similar to the following example code.

``` {.programlisting}
package com.vogella.android.test.simpleactivity.test;

import android.content.Intent;
import android.test.TouchUtils;
import android.test.suitebuilder.annotation.SmallTest;
import android.widget.Button;

import com.vogella.android.test.simpleactivity.MainActivity;

public class MainActivityUnitTest extends
    android.test.ActivityUnitTestCase<MainActivity> {

  private int buttonId;
  private MainActivity activity;

  public MainActivityUnitTest() {
    super(MainActivity.class);
  }
  @Override
  protected void setUp() throws Exception {
    super.setUp();
    Intent intent = new Intent(getInstrumentation().getTargetContext(),
        MainActivity.class);
    startActivity(intent, null, null);
    activity = getActivity();
  }

  public void testLayout() {
    buttonId = com.vogella.android.test.simpleactivity.R.id.button1;
    assertNotNull(activity.findViewById(buttonId));
    Button view = (Button) activity.findViewById(buttonId);
    assertEquals("Incorrect label of the button", "Start", view.getText());
  }

  public void testIntentTriggerViaOnClick() {
    buttonId = com.vogella.android.test.simpleactivity.R.id.button1;
    Button view = (Button) activity.findViewById(buttonId);
    assertNotNull("Button not allowed to be null", view);

    view.performClick();
    
    // TouchUtils cannot be used, only allowed in 
    // InstrumentationTestCase or ActivityInstrumentationTestCase2 
  
    // Check the intent which was started
    Intent triggeredIntent = getStartedActivityIntent();
    assertNotNull("Intent was null", triggeredIntent);
    String data = triggeredIntent.getExtras().getString("URL");

    assertEquals("Incorrect data passed via the intent",
        "http://www.vogella.com", data);
  }

} 
```

13. Exercise: functional test for activities
--------------------------------------------

### 13.1. Write functional test for activities

Create a test project called *com.vogella.android.intent.simple.test*. Create a new test class called *MainActivityFunctionalTest* based on the `ActivityInstrumentationTestCase2` class.

This class is used to develop the integration tests for the two activities.

``` {.programlisting}
package com.vogella.android.test.simpleactivity.test;

import android.app.Activity;
import android.app.Instrumentation;
import android.app.Instrumentation.ActivityMonitor;
import android.test.ActivityInstrumentationTestCase2;
import android.test.TouchUtils;
import android.test.ViewAsserts;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.vogella.android.test.simpleactivity.R;

import com.vogella.android.test.simpleactivity.MainActivity;
import com.vogella.android.test.simpleactivity.SecondActivity;

public class MainActivityFunctionalTest extends
    ActivityInstrumentationTestCase2<MainActivity> {

  private MainActivity activity;

  public MainActivityFunctionalTest() {
    super(MainActivity.class);
  }

  @Override
  protected void setUp() throws Exception {
    super.setUp();
    setActivityInitialTouchMode(false);
    activity = getActivity();
  }

} 
```

### 13.2. Write functional test for activities

``` {.programlisting}
package com.vogella.android.test.simpleactivity.test;

import android.app.Activity;
import android.app.Instrumentation;
import android.app.Instrumentation.ActivityMonitor;
import android.test.ActivityInstrumentationTestCase2;
import android.test.TouchUtils;
import android.test.ViewAsserts;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.vogella.android.test.simpleactivity.R;

import com.vogella.android.test.simpleactivity.MainActivity;
import com.vogella.android.test.simpleactivity.SecondActivity;

public class MainActivityFunctionalTest extends
    ActivityInstrumentationTestCase2<MainActivity> {

  private MainActivity activity;

  public MainActivityFunctionalTest() {
    super(MainActivity.class);
  }
  @Override
  protected void setUp() throws Exception {
    super.setUp();
    setActivityInitialTouchMode(false);
    activity = getActivity();
  }

  public void testStartSecondActivity() throws Exception {
    
    
    
    // add monitor to check for the second activity
    ActivityMonitor monitor =
        getInstrumentation().
          addMonitor(SecondActivity.class.getName(), null, false);

    // find button and click it
    Button view = (Button) activity.findViewById(R.id.button1);
    
    // TouchUtils handles the sync with the main thread internally
    TouchUtils.clickView(this, view);

    // to click on a click, e.g., in a listview
    // listView.getChildAt(0);

    // wait 2 seconds for the start of the activity
    SecondActivity startedActivity = (SecondActivity) monitor
        .waitForActivityWithTimeout(2000);
    assertNotNull(startedActivity);

    // search for the textView
    TextView textView = (TextView) startedActivity.findViewById(R.id.resultText);
    
    // check that the TextView is on the screen
    ViewAsserts.assertOnScreen(startedActivity.getWindow().getDecorView(),
        textView);
    // validate the text on the TextView
    assertEquals("Text incorrect", "Started", textView.getText().toString());
    
    // press back and click again
    this.sendKeys(KeyEvent.KEYCODE_BACK);
    
    TouchUtils.clickView(this, view);
  }
} 
```

To test the direct modification of a view, create the following test class for the `SecondActivity` class.

``` {.programlisting}
package com.vogella.android.test.simpleactivity.test;

import android.app.Activity;
import android.app.Instrumentation;
import android.app.Instrumentation.ActivityMonitor;
import android.test.ActivityInstrumentationTestCase2;
import android.test.TouchUtils;
import android.test.UiThreadTest;
import android.test.ViewAsserts;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.vogella.android.test.simpleactivity.R;

import com.vogella.android.test.simpleactivity.MainActivity;
import com.vogella.android.test.simpleactivity.SecondActivity;

public class SecondActivityFunctionalTest extends
    ActivityInstrumentationTestCase2<SecondActivity> {

  private static final String NEW_TEXT = "new text";

  public SecondActivityFunctionalTest() {
    super(SecondActivity.class);
  }

  public void testSetText() throws Exception {

    SecondActivity activity = getActivity();

    // search for the textView
    final TextView textView = (TextView) activity
        .findViewById(R.id.resultText);

    // set text
    getActivity().runOnUiThread(new Runnable() {

      @Override
      public void run() {
        textView.setText(NEW_TEXT);
      }
    });
    
    getInstrumentation().waitForIdleSync();
    assertEquals("Text incorrect", NEW_TEXT, textView.getText().toString());

  }

  @UiThreadTest
  public void testSetTextWithAnnotation() throws Exception {

    SecondActivity activity = getActivity();

    // search for the textView
    final TextView textView = (TextView) activity
        .findViewById(R.id.resultText);

    textView.setText(NEW_TEXT);
    assertEquals("Text incorrect", NEW_TEXT, textView.getText().toString());

  }

} 
```

14. More on Android testing
---------------------------

### 14.1. Android additional assertion

The Android testing API provides the `MoreAsserts` and `ViewAsserts` classes in addition to the standard JUnit `Assert` class.

### 14.2. Android test groups

You can annotate tests with `@SmallTest`, `@MediumTest` and `@LargeTest` and decide which test group you want to run.

The following screenshot shows the selection in the Run Configuration of Eclipse.

![Selecting test groups in Eclipse.](http://www.vogella.com/tutorials/AndroidTesting/images/xrunconfiguration_androidtests10.png.pagespeed.ic.moNa8kP7FZ.png)

This allows you to run, for example, only tests which do not run very long in Eclipse. Long running tests could than run only in the continuous integration server.

### 14.3. Flaky tests

Actions in Android are sometimes time dependent. To tell Android to repeat a test once it fails, use the `@FlakyTest` annotation. Via the *`tolerance`* attribute of this annotation you can define how often the Android test framework should try to repeat a test before marking it as failed.

15. Exercise: Run tests via Apache Ant
--------------------------------------

Update your test project called *com.vogella.android.test.simpleactivity.test* to have a `build.xml` file.

Afterwards, run the tests with the `ant test` command.

16. Testing asynchronous processing
-----------------------------------

Testing asynchronous is challenging. The typical approach is to use an instance of the `CountDownLatch` class in your test code and signal from the asynchronous processing that the processing was done.

For example the asynchronous processing would allow to register a listener for the processing to which test can subscribe.

For example create a project called `com.vogella.android.test.async` which allows to trigger an AsyncTask via a button.

The example code for the activity:

``` {.programlisting}
package com.vogella.android.test.async;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity {

  private IJobListener listener;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
  }

  public static interface IJobListener {
    void executionDone();
  }

  public void setListener(IJobListener listener) {
    this.listener = listener;
  }

  public void onClick(View view) {
    myTask.execute("test");
  }

  final AsyncTask<String, Void, String> myTask = new AsyncTask<String, Void, String>() {

    @Override
    protected String doInBackground(String... arg0) {
      return "Long running stuff";
    }

    @Override
    protected void onPostExecute(String result) {
      super.onPostExecute(result);
      if (listener != null) {
        listener.executionDone();
      }
    }

  };

} 
```

The example code for the test:

``` {.programlisting}
package com.vogella.android.test.async.test;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import android.content.Intent;
import android.test.ActivityUnitTestCase;
import android.widget.Button;

import com.vogella.android.test.async.MainActivity;
import com.vogella.android.test.async.MainActivity.IJobListener;
import com.vogella.android.test.async.R;

public class AsyncTaskTester extends ActivityUnitTestCase<MainActivity> {

  private MainActivity activity;

  public AsyncTaskTester() {
    super(MainActivity.class);
  }

  protected void setUp() throws Exception {
    super.setUp();
    Intent intent = new Intent(getInstrumentation().getTargetContext(),
        MainActivity.class);
    startActivity(intent, null, null);
    activity = getActivity();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
  }
  
  public void testSomeAsynTask () throws Throwable {
      // create CountDownLatch for which the test can wait.
      final CountDownLatch latch = new CountDownLatch(1);

      activity.setListener(new IJobListener() {
      
      @Override
      public void executionDone() {
        latch.countDown();
      }
    });
      
      // Execute the async task on the UI thread! THIS IS KEY!
      runTestOnUiThread(new Runnable() {

          @Override
          public void run() {
            Button button = (Button) activity.findViewById(R.id.button1);
            button.performClick();
          }
      });       

      
      boolean await = latch.await(30, TimeUnit.SECONDS);

      assertTrue(await);
  }

} 
```

17. User interface testing
--------------------------

### 17.1. Cross-component user interface testing

Functional or black-box user interface testing does test the complete application and not single components of your application.

### 17.2. uiautomator

The Android SDK contains the *uiautomator* Java library for creating user interface tests and provides an engine to run these user interface tests. Both tools work only as of API 16.

The uiautomator test projects are standalone Java projects which the JUnit3 library and the uiautomator.jar and android.jar files from the `android-sdk/platforms/api-version` directory added to the build path.

Androids uiautomator provides the `UiDevice` class to communicate with the device, the `UiSelector` class to search for elements on the screen and the `UiObject` which presents user interface elements and is created based on the `UiSelector` class. The `UiCollection` class allows to select a number of user interface elements at the same time and `UiScrollable` allows to scroll in a view to find an element.

The following coding shows an example test from the official Android developer side. The URL for this is [Testing UI example](http://developer.android.com/tools/testing/testing_ui.html#sample).

``` {.programlisting}
package com.uia.example.my;

// Import the uiautomator libraries
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiScrollable;
import com.android.uiautomator.core.UiSelector;
import com.android.uiautomator.testrunner.UiAutomatorTestCase;

public class LaunchSettings extends UiAutomatorTestCase {

  public void testDemo() throws UiObjectNotFoundException {

    // Simulate a short press on the HOME button.
    getUiDevice().pressHome();

    // We’re now in the home screen. Next, we want to simulate
    // a user bringing up the All Apps screen.
    // If you use the uiautomatorviewer tool to capture a snapshot
    // of the Home screen, notice that the All Apps button’s
    // content-description property has the value “Apps”. We can
    // use this property to create a UiSelector to find the button.
    UiObject allAppsButton = new UiObject(new UiSelector().description("Apps"));

    // Simulate a click to bring up the All Apps screen.
    allAppsButton.clickAndWaitForNewWindow();

    // In the All Apps screen, the Settings app is located in
    // the Apps tab. To simulate the user bringing up the Apps tab,
    // we create a UiSelector to find a tab with the text
    // label “Apps”.
    UiObject appsTab = new UiObject(new UiSelector().text("Apps"));

    // Simulate a click to enter the Apps tab.
    appsTab.click();

    // Next, in the apps tabs, we can simulate a user swiping until
    // they come to the Settings app icon. Since the container view
    // is scrollable, we can use a UiScrollable object.
    UiScrollable appViews = new UiScrollable(new UiSelector().scrollable(true));

    // Set the swiping mode to horizontal (the default is vertical)
    appViews.setAsHorizontalList();

    // create a UiSelector to find the Settings app and simulate
    // a user click to launch the app.
    UiObject settingsApp = appViews
        .getChildByText(new UiSelector()
            .className(android.widget.TextView.class.getName()),
            "Settings");
    settingsApp.clickAndWaitForNewWindow();

    // Validate that the package name is the expected one
    UiObject settingsValidation = new UiObject(new UiSelector()
        .packageName("com.android.settings"));
    assertTrue("Unable to detect Settings", settingsValidation.exists());
  }
} 
```

You need to use Apache Ant to build and deploy the corresponding project.

``` {.programlisting}
<android-sdk>/tools/android create uitest-project -n <name> -t 1 -p <path>

# build the test jar
ant build

# push JAR to device
ant push output.jar  /data/local/tmp/

# Run the test
adb shell uiautomator runtest LaunchSettings.jar -c com.uia.example.my.LaunchSettings 
```

### 17.3. uiautomatorviewer

Android provides the *uiautomatorviewer* tool, which allows you to analyze the user interface of an application. You can use this tool to find the index, text or attribute of the application.

This tool allows non-programmers to analyze an application and develop tests for it via the *uiautomator* library.

The tool is depicted in the following screenshot.

![uiautomatorviewer in usage](http://www.vogella.com/tutorials/AndroidTesting/images/xuiautomatorviewer10.png.pagespeed.ic.RoBZ7mNrdL.png)

18. Monkey
----------

Monkey is a command line tool which sends pseudo random events to your device. You can restrict Monkey to run only for a certain package and therefore instruct Monkey to test only your application.

For example, the following will send 2000 random events to the application with the `de.vogella.android.test.target` package.

``` {.programlisting}
adb shell monkey -p de.vogella.android.test.target -v 2000 
```

Monkey sometimes causes problems with the adb server. Use the following commands to restart the adb server.

``` {.programlisting}
adb kill-server
adb start-server 
```

You can use the *`-s [seed]`* parameter to ensure that the generated sequence of events is always the same.

For more info on Monkey please see the [Monkey description](http://developer.android.com/guide/developing/tools/monkey.html).

19. monkeyrunner
----------------

### 19.1. Testing with monkeyrunner

The *monkeyrunner* tool provides a Python API for writing programs that control an Android device or emulator from outside of Android code.

Via *monkeyrunner* you can completely script your test procedure. It runs via the *adb* debug bridge and allows you to install program, start them, control the flow and also take screenshots or your application.

To use *monkeyrunner*, ensure that you have Python installed on your machine and in your path.

In *monkeyrunner* you have primary the following classes:

-   MonkeyRunner: allows to connect to devices.

-   MonkeyDevice: allows to install and uninstall packages and to send keyboard and touch events to an application.

-   MonkeyImage: allows to create screenshots, compare screenshots and save them.

MonkeyImage can compare the screenshot with an existing image via the `sameAs()` method. A screenshot contains the Android notifcation bar, including time. You can enter a percentage as second parameter for `sameAs()` or use the `getSubImage()` method.

The API reference for *monkeyrunner* can be generated via the following command.

``` {.programlisting}
# outfile is the path qualified name
# of the output file
monkeyrunner help.py help <outfile> 
```

### 19.2. monkeyrunner example

Ensure Python is installed and in your path. Also ensure the `[android-sdk]/tools` folder is in your path. Create a file, for example, called *testrunner.py*

``` {.programlisting}
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
import commands
import sys
import os

# starting the application and test
print "Starting the monkeyrunner script"

if not os.path.exists("screenshots"):
    print "creating the screenshots directory"
    os.makedirs("screenshots")

# connection to the current device, and return a MonkeyDevice object
device = MonkeyRunner.waitForConnection()

apk_path = device.shell('pm path com.vogella.android.test.simpleactivity')
if apk_path.startswith('package:'):
    print "application installed."
else:
    print "not installed, install APK"
    device.installPackage('com.vogella.android.test.simpleactivity.apk')

print "starting application...."
device.startActivity(component='com.vogella.android.test.simpleactivity/[...CONTINUE]
com.vogella.android.test.simpleactivity.MainActivity')

#screenshot
MonkeyRunner.sleep(1)
result = device.takeSnapshot()
result.writeToFile('./screenshots/splash.png','png')
print "screenshot taken and stored on device"

#sending an event which simulate a click on the menu button
device.press('KEYCODE_MENU', MonkeyDevice.DOWN_AND_UP)

print "Finishing the test" 
```

You run this test via the `monkeyrunner testrunner.py` command on the console.

20. Common Android testing requires and solution approaches
-----------------------------------------------------------

### 20.1. Common logging on a server

Frequently the log files of the tests should be stored on a server and not on the device. A good practice is to provide a server backend and post the result via an HTTP request to this server. The server logs it centrally and provides central access to it.

### 20.2. Triggering system changes via tests

During tests you sometimes want to change the system status, e.g., turn WIFI of, for example. Typically, this cannot be done via the test directly, as the test only has the permissions of the application under test.

A good practice is to install another application on the device which has the required permission and trigger it via an *intent* from the test.

21. Espresso
------------

Google released the *Espresso* framework for testing in Oct. 2013. See [Espresso](https://code.google.com/p/android-test-kit) for instructions on how to use this framework.

22. Other Open Source testing frameworks
----------------------------------------

Robotium is an Open Source framework on top of the Android testing framework which makes the testing API simpler. See [Robotium](http://www.vogella.com/tutorials/Robotium/article.html) for user interface testing with the Robotium framework.

Robolectric is an Open Source framework which allows you to run tests which use the Android API directly on the JVM. See the [Robolectric tutorial](http://www.vogella.com/tutorials/Robolectric/article.html) for more information.

Roboguice allows you to use dependency injection in your Android components which simplifies testing. See [Using Roboguice](http://www.vogella.com/tutorials/RoboGuice/article.html).
