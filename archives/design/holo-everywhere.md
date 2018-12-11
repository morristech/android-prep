[![Android Developers Blog](http://3.bp.blogspot.com/-l7gnNEh4qg8/UKqmMerltLI/AAAAAAAAC-c/_aid9jTg9Zk/s1600/blogheader2.png)](http://android-developers.blogspot.com/)

03 January 2012
---------------

### Holo Everywhere

*[This post is by [Adam Powell](https://plus.google.com/107708120842840792570/posts), an Android Framework engineer who cares about style. —Tim Bray]*
 Android 4.0 showcases the Holo theme family, further refined since its debut in Android 3.0. But as most developers know, a new system theme for some Android devices isn’t a new or uncommon event. For developers new system themes mean more design targets for their apps. Using system themes means developers can take advantage of a user’s existing expectations and it can save a lot of production time, but only if an app designer can reliably predict the results. Before Android 4.0 the variance in system themes from device to device could make it difficult to design an app with a single predictable look and feel. We set out to improve this situation for the developer community in Ice Cream Sandwich and beyond.

![](http://3.bp.blogspot.com/-Ih4mfw7ugas/TwNnpaoc79I/AAAAAAAABAE/BmBauVfE7OA/s400/Screenshot_2011-11-17-22-19-53.png)

Theme.Holo

If you’re not already familiar with Android’s style and theme system, you should read [Styles and Themes](http://developer.android.com/guide/topics/ui/themes.html) before continuing.

### Compatibility Standard

In Android 4.0, Holo is different. We’ve made the inclusion of the unmodified Holo theme family a compatibility requirement for devices running Android 4.0 and forward. If the device has Android Market it will have the Holo themes as they were originally designed.
 This standardization goes for all of the public Holo widget styles as well. The Widget.Holo styles will be stable from device to device, safe for use as parent styles for incremental customizations within your app.
 The Holo theme family in Android 4.0 consists of the themes Theme.Holo, Theme.Holo.Light, and Theme.Holo.Light.DarkActionBar. Examples of these themes in action are shown in the screenshots lining this post.
 To use a Holo theme, explicitly request one from your manifest on your activity or application element, e.g. `android:theme="@android:style/Theme.Holo"`. Your app will be displayed using the unmodified theme on all compatible Android 4.0 devices. The Holo themes may also be used as stable parent themes for app-level theme customizations.

### What about device themes?

We have no desire to restrict manufacturers from building their own themed experience across their devices. In fact we’ve gone further to make this even easier. In Android 4.0’s API (level 14) we’ve added a new public theme family to complement the Holo family introduced in Android 3.0: DeviceDefault. DeviceDefault themes are aliases for the device’s native look and feel. The DeviceDefault theme family and widget style family offer ways for developers to target the device’s native theme with all customizations intact.

![](http://1.bp.blogspot.com/-Mi2BW-8T8eY/TwNpdVemR_I/AAAAAAAABAc/-oOTaZ5M4_A/s400/Screenshot_2011-11-17-22-23-18.png)

Theme.Holo.Light

Formally separating these theme families will also make future merges easier for manufacturers updating to a new platform version, helping more devices update more quickly. Google’s Nexus devices alias DeviceDefault to the unmodified Holo themes.

### Making use of your chosen theme

We’ve added a number of theme attributes to report common metrics and color palette info to apps that want to fit in with a theme. These include highlight colors, default padding and margins for common UI elements such as list items, and more. Apps that wish to integrate with their chosen theme (both Holo and DeviceDefault included) can refer to these theme attributes as in the examples below:
 Sample button with system-supplied touch highlight:

    <ImageButton android:id="@+id/my_button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:src="@drawable/button_icon"
        android:background="?android:attr/selectableItemBackground" />

Sample widget with a custom pressedHighlightColor attribute, value retrieved from the system theme:

    <MyWidget android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        myapp:pressedHighlightColor="?android:attr/colorPressedHighlight" />

Sample list item layout using system-supplied metrics and text appearance:

    <LinearLayout android:layout_width="match_parent"
        android:layout_height="?android:attr/listPreferredItemHeight"
        android:paddingLeft="?android:attr/listPreferredItemPaddingLeft"
        android:paddingRight="?android:attr/listPreferredItemPaddingRight">
        <TextView android:id="@+id/text"
            android:textAppearance="?android:attr/textAppearanceListItem" />
        <!-- Other views here -->
    </LinearLayout>

![](http://1.bp.blogspot.com/-99NqKnTQ2Ew/TwNp6O1LBVI/AAAAAAAABAo/TIQZ27oOhd4/s400/Screenshot_2011-11-17-22-24-28.png)

Theme.Holo.Light.DarkActionBar
 (Available in API level 14 and above)

### Defaults for Older Apps

If an app does not explicitly request a theme in its manifest, Android 4.0 will determine the default theme based on the app’s targetSdkVersion to maintain the app’s original expectations: For values less than 11, `@android:style/Theme`; between 11 and 13 `@android:style/Theme.Holo`; and for 14 and higher `@android:style/Theme.DeviceDefault`.

### Using Holo while supporting Android 2.x

Most Android developers will still want to support 2.x devices for a while as updates and new devices continue to roll out. This doesn’t stop you from taking advantage of newer themes on devices that support them though. Using Android’s resource system you can define themes for your app that are selected automatically based on the platform version of the device it’s running on.
 *Theme.Holo and Theme.Holo.Light have been available since API level 11, but Theme.Holo.Light.DarkActionBar is new in API level 14.*
 res/values/themes.xml:

    <resources>
        <style name="MyTheme" parent="@android:style/Theme">
            <!-- Any customizations for your app running on pre-3.0 devices here -->
        </style>
    </resources>

res/values-v11/themes.xml:

    <resources>
        <style name="MyTheme" parent="@android:style/Theme.Holo">
            <!-- Any customizations for your app running on devices with Theme.Holo here -->
        </style>
    </resources>

Finally, in AndroidManifest.xml:

    <!-- [...] -->
        <application android:name="MyApplication"
                android:label="@string/application_label"
                android:icon="@drawable/app_icon"
                android:hardwareAccelerated="true"
                android:theme="@style/MyTheme">
    <!-- [...] -->

You can go as far with this idea as you like, up to and including defining your own theme attributes with different values across configurations for use in your other resources. To learn more about Android’s resource system, see [Application Resources](http://developer.android.com/guide/topics/resources/index.html).

### Final Thoughts

Android apps running on 4.0 and forward can use the Holo themes and be assured that their look and feel will not change when running on a device with a custom skin. Apps that wish to use the device’s default styling can do so using the DeviceDefault themes that are now in the public API. These changes let you spend more time on your design and less time worrying about what will be different from one device to another. Finally, Android’s resource system allows you to support features from the latest platform version while offering graceful fallback on older devices.

Posted by Tim Bray at [1:35 PM](http://android-developers.blogspot.com/2012/01/holo-everywhere.html "permanent link")

Labels: [App Resources](http://android-developers.blogspot.com/search/label/App%20Resources), [User Interface](http://android-developers.blogspot.com/search/label/User%20Interface)


