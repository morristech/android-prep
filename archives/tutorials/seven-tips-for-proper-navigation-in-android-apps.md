Seven Tips for Proper Navigation in Android Apps
================================================

By following just a few simple principles, says Jason Ostrander, author
of [Android UI Fundamentals: Develop &
Design](http://www.peachpit.com/store/product.aspx?isbn=0321814584),
Android developers can minimize user frustration with navigation in
their apps.

Android development has exploded in recent years, making Android the
largest smartphone OS by market share. As its user base increases, so do
the number and quality of apps in the Google Play store. However, one
area where developers still seem to struggle is with Android's
navigation model. Many apps fail to handle the nuances of activities and
tasks properly, forcing users to endure endless back pressing to exit an
app. To address this issue, this article presents seven tips for proper
implementation of navigation in your Android app.

### Learn from the Android Documentation

For many years, the Android documentation on navigation has been
lacking. Luckily, Google has recently addressed this problem, and now
there are many resources explaining how to navigate an Android app. In
particular, the [design guidelines](http://developer.android.com/design/patterns/navigation.html) and [navigation training article](http://developer.android.com/training/design-navigation/index.html)
provide clear case studies, working through the high-level application
use case and following through with individual screens and the actions
of the back and up buttons. You should read both of these resources and
think carefully about your own application and how you expect people to
use it. In addition, you should understand the basics of [tasks and the back stack](http://developer.android.com/guide/topics/fundamentals/tasks-and-back-stack.html) to leverage Android effectively.

### Learn the Difference Between Up and Back

Android version 3.0 introduced a standardized navigation element called
the ActionBar. This bar sits at the top of the screen and contains
common actions and navigation elements, such as tabs. It also includes
an icon on the left side that can be used as an up button.

![](http://www.peachpit.com/content/images/art_ostrander1_appnav/elementLinks/thostrander1_fig01.jpg)

The up button as displayed in the Google Play app.

It's important to understand the differences between the up and the back
button. First, the up button is only relevant within your app. It will
never take the user to a different application. In addition, the concept
of *up* means that the user will return to a "logical" parent of the
current activity. In the Gmail app, for example, pressing the up button
while viewing an email message would take you to a list of email
messages. If no parent exists, up should take the user to the "home"
activity of your app.

The back button, on the other hand, moves back through the stack of
recent activities. This is limited to those activities in the current
task (more about that in a moment). Think of it like the browser's back
button. As a user navigates through an app and into others, the back
button will take him backward through those activities, until he reaches
the launcher. Once the user reaches the launcher, he can no longer press
back.

### Understand How Tasks Relate to the Back Stack

*Tasks* are collections of activities opened in chronological order by
the user. A new task is created when the user opens an application from
the launcher. Moving from one application to another generally doesn't
start a new task. Instead, the new activity becomes part of the existing
task. For example, if you navigate from an existing app to the Google
Maps app, the displayed map will be part of the existing app task.
Pressing back from the map will take the user back to the original app.

Each Android task has an associated *back stack*. The back stack can
seem complicated at first, but its implementation is firmly rooted in
basic computer science. It's just a stack. The elements in the stack are
the screens of an app, called *activities*. As you navigate from one
activity to another, the previous activity is pushed onto the stack.
When you press the back button, the current activity (the current screen
displayed to the user) is destroyed, and the activity at the top of the
back stack is popped off and displayed to the user. If the back stack is
empty, the user is taken back to the launcher.

An important point to note is that the system will not keep tasks around
forever. When it needs resources, it will often clear the task and
corresponding back stack. This is quite common, and you shouldn't rely
on any particular back stack state to exist for your app to function
correctly. If you really need it, however, it's possible to disable this
behavior by setting the `alwaysRetainTaskState` attribute on an activity
in your manifest.

### Define the Proper Activity Attributes

By default, new activities are launched into existing tasks. This can be
changed by setting activity attributes in your application manifest. For
example, setting the `launchMode` attribute to `singleTask` ensures that
only a single instance of an activity will be created:

    <activity android:name=".TestActivity" 
        android:launchMode="singleTask">
    </activity>

Now, intents for `TestActivity` will resume any task that already
contains `TestActivity`, rather than creating another instance. If no
instance exists, the system creates a new task containing `TestActivity`
as normal.

Another useful activity attribute is `taskAffinity`. You can use
`taskAffinity` to assign an activity to a particular task. By default,
all activities in your application have the same affinity. Using the
`taskAffinity` attribute, you can group them into separate tasks or even
assign them to tasks in other applications. Here, the `TestActivity` is
assigned to a specific task:

    <activity android:name=".TestActivity" 
        android:taskAffinity="com.example.SecondTask">
    </activity>

Read the Android documentation for a full explanation of the activity
attributes available for controlling tasks.

### Use Intent Flags

Activity attributes work well when you always want the same behavior for
an activity. But sometimes you need control over a specific activity
launch. For those cases, use `Intent` flags. `Intent`s are used to
launch activities on Android. You can set flags that control the task
that will contain the activity. Flags exist to create a new activity,
use an existing activity, or bring an existing instance of an activity
to the front.

For example, it's common to launch an activity when the user taps a
notification. Often, apps will use the default intent flags, resulting
in multiple copies of the same activity in the back stack. This forces
the user to press back repeatedly while each instance of the activity is
popped off the back stack. To fix this problem, set the flags
`Intent.FLAG_ACTIVITY_NEW_TASK` and `Intent.FLAG_ACTIVITY_CLEAR_TASK` to
switch to an existing instance of the activity and clear any other
activities on top of it:

    Intent intent = new Intent(context, TestActivity.class);
    intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
    startActivity(intent);

Note that in Android API version 11, the `Intent `class includes new
static methods that create intents with the proper flags already set.
Look [here](http://developer.android.com/reference/android/content/Intent.html#makeRestartActivityTask(android.content.ComponentName)) for an example.

### Use the New Compatibility Package Classes

Google's recent update to the compatibility package added two new
utility classes to aid with app navigation. The first of these utilities
is called `NavUtils`. It provides static methods for navigating up to
the parent of the current activity, as declared in your application
manifest. Here is an example manifest entry:

    <activity android:name=".TestActivity" >
        <meta-data android:name="android.support.PARENT_ACTIVITY"
            android:value=".TestParentActivity">
        </meta-data>
    </activity>

`TestParentActivity` is declared as a parent of `TestActivity` using a
metadata element.

Now, in the `TestActivity` class, `NavUtils` is used to navigate up to
`TestParentActivity` when the user presses the up button:

    @Override
    public boolean onOptionsItemSelected(android.view.MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            NavUtils.navigateUpFromSameTask(this);
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

The up button uses the same resource identifier as the `ActionBar` home
icon, `android.R.id.home`. In addition to navigation, the `NavUtils`
class provides a `Boolean` method specifying whether the current
activity should display an up button.

The second class is `TaskStackBuilder`. This class can be used to
construct a complete back stack, with a root activity and several
activities on top of it. This back stack is created with a stack of
intents. Calling `startActivities()` will create the back stack using
the intents to create each activity and pushing it onto the stack.

    TaskStackBuilder tsb = TaskStackBuilder.from(this);
    tsb.addParentStack(this);
    tsb.addNextIntent(new Intent(this, TestActivity.class));
    tsb.addNextIntent(new Intent(this, TestActivity.class));
    tsb.addNextIntent(new Intent(this, TestActivity.class));
    tsb.startActivities();

This example adds three copies of the `TestActivity` to the current back
stack. The user will have to press back three times to return to the
existing activity. Using `TaskStackBuilder`, you can create tasks with
entire back stack histories from scratch.

### Test Your App

The last tip should be obvious: Test your app. Spend time testing all
the different ways users can enter the activities in your application.
If you provide an activity that can be reached from multiple places (a
settings activity, for example), test navigating to it from throughout
your app to see if it creates more than one instance. Think carefully
about whether you want users to be pressing back through multiple copies
of the same activity.

Test entering your application from notifications, widgets, and other
apps. Be aware of possible memory issues. If you create multiple
instances of a memory-intensive activity, it can cause an
`OutOfMemoryException`. If your app provides a service that other apps
might use, such as messaging, test how the user will move from other
apps into your app. Follow the principle of least surprise. You never
want users to be confused about why they're seeing a particular
activity.

### Conclusion

With each new release, Android development becomes easier. But you still
need to think about navigation basics if you want to provide the best
possible experience. Remember, users expect your app to behave like
other Android apps. It's not enough to port existing user interfaces
from other platforms. By learning the platform, thinking through the
user interaction of your app, and thoroughly testing, you can create an
app that delights its users.
