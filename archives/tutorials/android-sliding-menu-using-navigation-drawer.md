[![androidhive](http://www.androidhive.info/wp-content/themes/androidhive_v2_analytics/img/logo.png)](http://www.androidhive.info)

November 13, 2013 05:20 AM

Android Sliding Menu using Navigation Drawer
============================================
You might have noticed that lot of android applications introduced a
sliding panel menu to navigate between major modules of the application.
Previously this kind of UI was done using some third party libraries
where a list view and some swiping gestures used to achieve this. But
now android itself officially introduced sliding panel menu by
introducing a newer concept called [Navigation Drawer](http://developer.android.com/design/patterns/navigation-drawer.html).

Most of the time Sliding Menu (Navigation Drawer) will be hidden and can
be shown by swiping the screen from left edge to right or tapping the
app icon on the action bar.

In this tutorial we are going to learn how to use navigation drawer to
add a sliding menu to your application.

[DOWNLOAD CODE](http://download.androidhive.info/download?code=nePLuQPt2OCa9CDCWoVa0VRubiMENJPvFozE%2BLVVaQ8LZSW7xasdcttGU282b1%2Fv3oQAJAGjMSgMmeXKWRWj3pj%2B96QgOQc8i5yl5HcLkDhZu8tqpzpp%2BXSvg%3D%3DrUi3rrXE6m7Ou2tP3tIqGcNtn1w11RF36GI)

![android navigation drawer slider
menu](http://www.androidhive.info/wp-content/uploads/2013/11/android-navigation-drawer-slider-menu.jpg)

Example Applications
--------------------

You can see lot of popular applications like Facebook, Youtube, Google +
already introduced navigation drawer menu in their applications.
Following are the navigation drawer menus of multiple apps.

![android navigation drawer facebook, google plus,
youtube](http://www.androidhive.info/wp-content/uploads/2013/11/sliding-menu-example-applications.jpg)

In order to demonstrate navigation drawer, I am taking an example of
**Google+** navigation drawer and explained the process to achieve the
same. But before starting the project I have downloaded required icons
and using photoshop I have made each icon into different dimensions for
**xxhdpi (144×144 px)**, **xhdpi (96×96 px)**, **hdpi (72×72 px)** and
**mdpi (48×48 px)** drawbles.

Also I have downloaded navigation drawer toggle icon and included in
drawable folders. You can get all the images in the source code of this
tutorial. We need another image to replace the action bar up icon to
toggle navigation drawer. Save following images and later add them to
your project.

![ic\_drawer](http://www.androidhive.info/wp-content/uploads/2013/11/ic_drawer.png) ![ic\_drawer](http://www.androidhive.info/wp-content/uploads/2013/11/ic_drawer1.png) ![ic\_drawer](http://www.androidhive.info/wp-content/uploads/2013/11/ic_drawer2.png)

  
  
 Let’s start by creating a new project..

Starting new Project
--------------------

**1**. Create a new project in Eclipse from **File ⇒ New ⇒ Android
Application Project**. I had left my main activity name as
**MainActivity.java** and gave the package name as
**info.androidhive.slidingmenu**.

**2**. I prepared required string variables for List View items and icon
names in strings.xml. Open your **strings.xml** located under **res ⇒
values** and add the following code.

    <?xml version="1.0" encoding="utf-8"?>
    <resources>

        <string name="app_name">Slider Menu</string>
        <string name="action_settings">Settings</string>
        <string name="hello_world">Hello world!</string>
        <string name="drawer_open">Slider Menu Opened</string>
        <string name="drawer_close">Slider Menu Closed</string>
        
        <!-- Nav Drawer Menu Items -->
        <string-array name="nav_drawer_items">
            <item >Home</item>
            <item >Find People</item>
            <item >Photos</item>
            <item >Communities</item>
            <item >Pages</item>
            <item >What\'s Hot</item>
        </string-array>
        
        <!-- Nav Drawer List Item Icons -->
        <!-- Keep them in order as the titles are in -->
        <array name="nav_drawer_icons">
            <item>@drawable/ic_home</item>
            <item>@drawable/ic_people</item>
            <item>@drawable/ic_photos</item>
            <item>@drawable/ic_communities</item>
            <item>@drawable/ic_pages</item>
            <item>@drawable/ic_whats_hot</item>
        </array>
        
        <!-- Content Description -->
        <string name="desc_list_item_icon">Item Icon</string>

    </resources>

**3**. Android introduced a newer UI element called
[DrawerLayout](http://developer.android.com/reference/android/support/v4/widget/DrawerLayout.html)
for Navigation Drawer. Open your layout file (**activity\_main.xml**)
for main activity and type the following code.

Here **FrameLayout** is used to replace the main content using
**Fragments** and it should be always the first child of the layout for
z-index purpose.

    <android.support.v4.widget.DrawerLayout
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:id="@+id/drawer_layout"
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <!-- Framelayout to display Fragments -->
        <FrameLayout
            android:id="@+id/frame_container"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />

        <!-- Listview to display slider menu -->
        <ListView
            android:id="@+id/list_slidermenu"
            android:layout_width="240dp"
            android:layout_height="match_parent"
            android:layout_gravity="start"
            android:choiceMode="singleChoice"
            android:divider="@color/list_divider"
            android:dividerHeight="1dp"        
            android:listSelector="@drawable/list_selector"
            android:background="@color/list_background"/>
    </android.support.v4.widget.DrawerLayout>

  

Creating Custom List View Adapter
---------------------------------

Creating a listview with a icon, title and a counter isn’t straight
forward. We have to build a custom listview to achieve this. For this I
am going to create a custom adpater class for listview which provides a
custom layout for individual list item in the listview.

Before start coding the custom adapter, I am going to create required
layout files for the list view.

We need the layout drawables to state the list item state when normal
and pressed. It needs overall three xml files. One is for normal state,
second is for pressed state and third one to combine both the layouts.

**4**. So create a xml file under **res ⇒ drawable** folder named
**list\_item\_bg\_normal.xml** and paste the following code. (If you
don’t see drawable folder, create a new folder and name it as drawable)

    <shape xmlns:android="http://schemas.android.com/apk/res/android"
        android:shape="rectangle">
      <gradient
          android:startColor="@color/list_background"
          android:endColor="@color/list_background"
          android:angle="90" />
    </shape>

**5**. Create another xml layout under **res ⇒ drawable** named
**list\_item\_bg\_pressed.xml** with following content.

    <shape xmlns:android="http://schemas.android.com/apk/res/android"
        android:shape="rectangle">
      <gradient
          android:startColor="@color/list_background_pressed"
          android:endColor="@color/list_background_pressed"
          android:angle="90" />
    </shape>

**6**. Create another xml file to combine both the drawable states under
**res ⇒ drawable** named **list\_selector.xml**

    <?xml version="1.0" encoding="utf-8"?>
    <selector xmlns:android="http://schemas.android.com/apk/res/android">

        <item android:drawable="@drawable/list_item_bg_normal" android:state_activated="false"/>
        <item android:drawable="@drawable/list_item_bg_pressed" android:state_pressed="true"/>
        <item android:drawable="@drawable/list_item_bg_pressed" android:state_activated="true"/>

    </selector>

**7**. We need one more drawable xml for rounde corner background for
the counter value. So create a xml file named **counter\_bg.xml** under
**res ⇒ drawable**.

If you want to know how to add a rounded corner border layout, you can
learn from [How to add Rounded Corner borders to Android
Layout](http://tips.androidhive.info/2013/09/android-layout-rounded-corner-border/)

    <?xml version="1.0" encoding="utf-8"?>
    <shape xmlns:android="http://schemas.android.com/apk/res/android"
        android:shape="rectangle" >

        <!-- view background color -->
        <solid android:color="@color/counter_text_bg" >
        </solid>

        <!-- If you want to add some padding -->
        <padding
            android:right="3dp"
            android:left="3dp" >
        </padding>

        <!-- Here is the corner radius -->
        <corners android:radius="2dp" >
        </corners>

    </shape>

**8**. As listview has the custom layout, we need another layout file
which defines the each list row. So create a layout file under **res ⇒
layout** named **drawer\_list\_item.xml**. This is a relative layout
which places the icon, title and counter relative to one another.

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="48dp" 
        android:background="@drawable/list_selector">

        <ImageView
            android:id="@+id/icon"
            android:layout_width="25dp"
            android:layout_height="wrap_content"
            android:layout_alignParentLeft="true"
            android:layout_marginLeft="12dp"
            android:layout_marginRight="12dp"
            android:contentDescription="@string/desc_list_item_icon"
            android:src="@drawable/ic_home"
            android:layout_centerVertical="true" />

        <TextView
            android:id="@+id/title"
            android:layout_width="wrap_content"
            android:layout_height="match_parent"
            android:layout_toRightOf="@id/icon"
            android:minHeight="?android:attr/listPreferredItemHeightSmall"
            android:textAppearance="?android:attr/textAppearanceListItemSmall"
            android:textColor="@color/list_item_title"
            android:gravity="center_vertical"
            android:paddingRight="40dp"/>
        
        <TextView android:id="@+id/counter"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:background="@drawable/counter_bg"
            android:layout_alignParentRight="true"
            android:layout_centerVertical="true"
            android:layout_marginRight="8dp"
            android:textColor="@color/counter_text_color"/>

    </RelativeLayout>

As each list item contains three elements icon, title and a counter, I
would like create a model to represent each list row.

**9**. I prefer to create a new package to keep all the model classes.
So create a new package named **info.androidhive.slidingmenu.model**

**10**. Under model package create a new class named
**NavDrawerItem.java** and paste the following code. Here
**isCounterVisible** defines the visibility of the counter value. If you
don’t want to show a counter for a particular list item you can set this
to false.

    package info.androidhive.slidingmenu.model;

    public class NavDrawerItem {
        
        private String title;
        private int icon;
        private String count = "0";
        // boolean to set visiblity of the counter
        private boolean isCounterVisible = false;
        
        public NavDrawerItem(){}

        public NavDrawerItem(String title, int icon){
            this.title = title;
            this.icon = icon;
        }
        
        public NavDrawerItem(String title, int icon, boolean isCounterVisible, String count){
            this.title = title;
            this.icon = icon;
            this.isCounterVisible = isCounterVisible;
            this.count = count;
        }
        
        public String getTitle(){
            return this.title;
        }
        
        public int getIcon(){
            return this.icon;
        }
        
        public String getCount(){
            return this.count;
        }
        
        public boolean getCounterVisibility(){
            return this.isCounterVisible;
        }
        
        public void setTitle(String title){
            this.title = title;
        }
        
        public void setIcon(int icon){
            this.icon = icon;
        }
        
        public void setCount(String count){
            this.count = count;
        }
        
        public void setCounterVisibility(boolean isCounterVisible){
            this.isCounterVisible = isCounterVisible;
        }
    }

**11**. Also create another package to keep all the adapter classes.
Create a package named **info.androidhive.slidingmenu.adapter**.

**12**. Now we have all the files required for custom list adapter. So
create a class named **NavDrawerListAdapter.java** under adapter
package.

    package info.androidhive.slidingmenu.adapter;

    import info.androidhive.slidingmenu.R;
    import info.androidhive.slidingmenu.model.NavDrawerItem;

    import java.util.ArrayList;

    import android.app.Activity;
    import android.content.Context;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;
    import android.widget.BaseAdapter;
    import android.widget.ImageView;
    import android.widget.TextView;

    public class NavDrawerListAdapter extends BaseAdapter {
        
        private Context context;
        private ArrayList<NavDrawerItem> navDrawerItems;
        
        public NavDrawerListAdapter(Context context, ArrayList<NavDrawerItem> navDrawerItems){
            this.context = context;
            this.navDrawerItems = navDrawerItems;
        }

        @Override
        public int getCount() {
            return navDrawerItems.size();
        }

        @Override
        public Object getItem(int position) {       
            return navDrawerItems.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            if (convertView == null) {
                LayoutInflater mInflater = (LayoutInflater)
                        context.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
                convertView = mInflater.inflate(R.layout.drawer_list_item, null);
            }
             
            ImageView imgIcon = (ImageView) convertView.findViewById(R.id.icon);
            TextView txtTitle = (TextView) convertView.findViewById(R.id.title);
            TextView txtCount = (TextView) convertView.findViewById(R.id.counter);
             
            imgIcon.setImageResource(navDrawerItems.get(position).getIcon());        
            txtTitle.setText(navDrawerItems.get(position).getTitle());
            
            // displaying count
            // check whether it set visible or not
            if(navDrawerItems.get(position).getCounterVisibility()){
                txtCount.setText(navDrawerItems.get(position).getCount());
            }else{
                // hide the counter view
                txtCount.setVisibility(View.GONE);
            }
            
            return convertView;
        }

    }

Until now we are done creating all the required layouts, model and
adapter class for navigation drawer. It’s time to move on to our
**MainActivity.java** and start implementing the navigation drawer.

Following are the major steps we need take care of in the main activity.

**\>** Creating a NavDrawerListAdapter instance and adding list items.  
 **\>** Assigning the adapter to Navigation Drawer ListView  
 **\>** Creating click event listener for list items  
 **\>** Creating and displaying fragment activities on selecting list
item.

**13**. So open your **MainActivity.java** and add the following code.
In the following code, we declared required variables, loaded the list
items titles and icons from strings.xml, created an adapter and added
each list item. Finally we added a navigation drawer listener.

*invalidateOptionsMenu()* is called in **onDrawerOpened()** and
**onDrawerClosed()** to hide and show the action bar icons on navigation
drawer opened and closed.

    public class MainActivity extends Activity {
        private DrawerLayout mDrawerLayout;
        private ListView mDrawerList;
        private ActionBarDrawerToggle mDrawerToggle;

        // nav drawer title
        private CharSequence mDrawerTitle;

        // used to store app title
        private CharSequence mTitle;

        // slide menu items
        private String[] navMenuTitles;
        private TypedArray navMenuIcons;

        private ArrayList<NavDrawerItem> navDrawerItems;
        private NavDrawerListAdapter adapter;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            mTitle = mDrawerTitle = getTitle();

            // load slide menu items
            navMenuTitles = getResources().getStringArray(R.array.nav_drawer_items);

            // nav drawer icons from resources
            navMenuIcons = getResources()
                    .obtainTypedArray(R.array.nav_drawer_icons);

            mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
            mDrawerList = (ListView) findViewById(R.id.list_slidermenu);

            navDrawerItems = new ArrayList<NavDrawerItem>();

            // adding nav drawer items to array
            // Home
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[0], navMenuIcons.getResourceId(0, -1)));
            // Find People
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[1], navMenuIcons.getResourceId(1, -1)));
            // Photos
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[2], navMenuIcons.getResourceId(2, -1)));
            // Communities, Will add a counter here
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[3], navMenuIcons.getResourceId(3, -1), true, "22"));
            // Pages
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[4], navMenuIcons.getResourceId(4, -1)));
            // What's hot, We  will add a counter here
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[5], navMenuIcons.getResourceId(5, -1), true, "50+"));
            

            // Recycle the typed array
            navMenuIcons.recycle();

            // setting the nav drawer list adapter
            adapter = new NavDrawerListAdapter(getApplicationContext(),
                    navDrawerItems);
            mDrawerList.setAdapter(adapter);

            // enabling action bar app icon and behaving it as toggle button
            getActionBar().setDisplayHomeAsUpEnabled(true);
            getActionBar().setHomeButtonEnabled(true);

            mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
                    R.drawable.ic_drawer, //nav menu toggle icon
                    R.string.app_name, // nav drawer open - description for accessibility
                    R.string.app_name // nav drawer close - description for accessibility
            ){
                public void onDrawerClosed(View view) {
                    getActionBar().setTitle(mTitle);
                    // calling onPrepareOptionsMenu() to show action bar icons
                    invalidateOptionsMenu();
                }

                public void onDrawerOpened(View drawerView) {
                    getActionBar().setTitle(mDrawerTitle);
                    // calling onPrepareOptionsMenu() to hide action bar icons
                    invalidateOptionsMenu();
                }
            };
            mDrawerLayout.setDrawerListener(mDrawerToggle);

            if (savedInstanceState == null) {
                // on first time display view for first nav item
                displayView(0);
            }
        }

        @Override
        public boolean onCreateOptionsMenu(Menu menu) {
            getMenuInflater().inflate(R.menu.main, menu);
            return true;
        }

        @Override
        public boolean onOptionsItemSelected(MenuItem item) {
            // toggle nav drawer on selecting action bar app icon/title
            if (mDrawerToggle.onOptionsItemSelected(item)) {
                return true;
            }
            // Handle action bar actions click
            switch (item.getItemId()) {
            case R.id.action_settings:
                return true;
            default:
                return super.onOptionsItemSelected(item);
            }
        }

        /***
         * Called when invalidateOptionsMenu() is triggered
         */
        @Override
        public boolean onPrepareOptionsMenu(Menu menu) {
            // if nav drawer is opened, hide the action items
            boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);
            menu.findItem(R.id.action_settings).setVisible(!drawerOpen);
            return super.onPrepareOptionsMenu(menu);
        }

        @Override
        public void setTitle(CharSequence title) {
            mTitle = title;
            getActionBar().setTitle(mTitle);
        }

        /**
         * When using the ActionBarDrawerToggle, you must call it during
         * onPostCreate() and onConfigurationChanged()...
         */

        @Override
        protected void onPostCreate(Bundle savedInstanceState) {
            super.onPostCreate(savedInstanceState);
            // Sync the toggle state after onRestoreInstanceState has occurred.
            mDrawerToggle.syncState();
        }

        @Override
        public void onConfigurationChanged(Configuration newConfig) {
            super.onConfigurationChanged(newConfig);
            // Pass any configuration change to the drawer toggls
            mDrawerToggle.onConfigurationChanged(newConfig);
        }

Now if you run your project you can see the navigation drawer with a
listview. You can open the navigation drawer either clicking on action
bar app icon or swiping the screen left edge to right. But you can
notice that the click event for list item not working as it is not
enabled yet.

  

Creating Fragment Views for individual List Item
------------------------------------------------

You can see we have **Home**, **Find People**, **Photos**,
**Communities**, **Pages** and **What’s Hot** in the list view. Here
each list item represents a view where each view needs a **Fragment**
class and a **xml layout** file.

**14**. So create a class file named **HomeFragment.java** and a layout
file named **fragment\_home.xml** with following content. For demo
purpose I have created very simple layout for this view. You can
customize this view depending on your app design.

    package info.androidhive.slidingmenu;

    import android.app.Fragment;
    import android.os.Bundle;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;

    public class HomeFragment extends Fragment {
        
        public HomeFragment(){}
        
        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
     
            View rootView = inflater.inflate(R.layout.fragment_home, container, false);
             
            return rootView;
        }
    }

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent">
        
        <TextView
            android:id="@+id/txtLabel"
             android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerInParent="true"
            android:textSize="16dp"
            android:text="Home View"/>
        
        <ImageView android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_below="@id/txtLabel"
            android:src="@drawable/ic_home"
            android:layout_centerHorizontal="true"
            android:layout_marginTop="10dp"/>
        

    </RelativeLayout>

Also you need to create remaining fragment classes and layout files for
other list items.

  

Handling Navigation Drawer List Item Click Event
------------------------------------------------

When user selects a list item from navigation drawer, we need to display
respected view in the main view. This can be done by adding a list item
click listener and loading respected fragment view in the call back
event.

**15**. Open the **MainActivity.java** and add the following code. Here
we added a click listener and loaded the related fragment view.

    public class MainActivity extends Activity {
    ..
    ..
        @Override
        protected void onCreate(Bundle savedInstanceState) {
        ..
        mDrawerList.setOnItemClickListener(new SlideMenuClickListener());
        }

        /**
         * Slide menu item click listener
         * */
        private class SlideMenuClickListener implements
                ListView.OnItemClickListener {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position,
                    long id) {
                // display view for selected nav drawer item
                displayView(position);
            }
        }

         /**
         * Diplaying fragment view for selected nav drawer list item
         * */
        private void displayView(int position) {
            // update the main content by replacing fragments
            Fragment fragment = null;
            switch (position) {
            case 0:
                fragment = new HomeFragment();
                break;
            case 1:
                fragment = new FindPeopleFragment();
                break;
            case 2:
                fragment = new PhotosFragment();
                break;
            case 3:
                fragment = new CommunityFragment();
                break;
            case 4:
                fragment = new PagesFragment();
                break;
            case 5:
                fragment = new WhatsHotFragment();
                break;

            default:
                break;
            }

            if (fragment != null) {
                FragmentManager fragmentManager = getFragmentManager();
                fragmentManager.beginTransaction()
                        .replace(R.id.frame_container, fragment).commit();

                // update selected item and title, then close the drawer
                mDrawerList.setItemChecked(position, true);
                mDrawerList.setSelection(position);
                setTitle(navMenuTitles[position]);
                mDrawerLayout.closeDrawer(mDrawerList);
            } else {
                // error in creating fragment
                Log.e("MainActivity", "Error in creating fragment");
            }
        }
    }

Now run the project and test the listview click event. You can see
respected fragment is loading on selecting the list item. Following is
the screenshot of my slider menu.

![android navigation drawer sliding menu](http://www.androidhive.info/wp-content/uploads/2013/11/android-navigation-drawer-sliding-menu.png)

  

Final Code
----------

**MainActivity.java**

    package info.androidhive.slidingmenu;

    import info.androidhive.slidingmenu.adapter.NavDrawerListAdapter;
    import info.androidhive.slidingmenu.model.NavDrawerItem;

    import java.util.ArrayList;

    import android.app.Activity;
    import android.app.Fragment;
    import android.app.FragmentManager;
    import android.content.res.Configuration;
    import android.content.res.TypedArray;
    import android.os.Bundle;
    import android.support.v4.app.ActionBarDrawerToggle;
    import android.support.v4.widget.DrawerLayout;
    import android.util.Log;
    import android.view.Menu;
    import android.view.MenuItem;
    import android.view.View;
    import android.widget.AdapterView;
    import android.widget.ListView;

    public class MainActivity extends Activity {
        private DrawerLayout mDrawerLayout;
        private ListView mDrawerList;
        private ActionBarDrawerToggle mDrawerToggle;

        // nav drawer title
        private CharSequence mDrawerTitle;

        // used to store app title
        private CharSequence mTitle;

        // slide menu items
        private String[] navMenuTitles;
        private TypedArray navMenuIcons;

        private ArrayList<NavDrawerItem> navDrawerItems;
        private NavDrawerListAdapter adapter;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            mTitle = mDrawerTitle = getTitle();

            // load slide menu items
            navMenuTitles = getResources().getStringArray(R.array.nav_drawer_items);

            // nav drawer icons from resources
            navMenuIcons = getResources()
                    .obtainTypedArray(R.array.nav_drawer_icons);

            mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
            mDrawerList = (ListView) findViewById(R.id.list_slidermenu);

            navDrawerItems = new ArrayList<NavDrawerItem>();

            // adding nav drawer items to array
            // Home
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[0], navMenuIcons.getResourceId(0, -1)));
            // Find People
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[1], navMenuIcons.getResourceId(1, -1)));
            // Photos
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[2], navMenuIcons.getResourceId(2, -1)));
            // Communities, Will add a counter here
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[3], navMenuIcons.getResourceId(3, -1), true, "22"));
            // Pages
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[4], navMenuIcons.getResourceId(4, -1)));
            // What's hot, We  will add a counter here
            navDrawerItems.add(new NavDrawerItem(navMenuTitles[5], navMenuIcons.getResourceId(5, -1), true, "50+"));
            

            // Recycle the typed array
            navMenuIcons.recycle();

            mDrawerList.setOnItemClickListener(new SlideMenuClickListener());

            // setting the nav drawer list adapter
            adapter = new NavDrawerListAdapter(getApplicationContext(),
                    navDrawerItems);
            mDrawerList.setAdapter(adapter);

            // enabling action bar app icon and behaving it as toggle button
            getActionBar().setDisplayHomeAsUpEnabled(true);
            getActionBar().setHomeButtonEnabled(true);

            mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
                    R.drawable.ic_drawer, //nav menu toggle icon
                    R.string.app_name, // nav drawer open - description for accessibility
                    R.string.app_name // nav drawer close - description for accessibility
            ) {
                public void onDrawerClosed(View view) {
                    getActionBar().setTitle(mTitle);
                    // calling onPrepareOptionsMenu() to show action bar icons
                    invalidateOptionsMenu();
                }

                public void onDrawerOpened(View drawerView) {
                    getActionBar().setTitle(mDrawerTitle);
                    // calling onPrepareOptionsMenu() to hide action bar icons
                    invalidateOptionsMenu();
                }
            };
            mDrawerLayout.setDrawerListener(mDrawerToggle);

            if (savedInstanceState == null) {
                // on first time display view for first nav item
                displayView(0);
            }
        }

        /**
         * Slide menu item click listener
         * */
        private class SlideMenuClickListener implements
                ListView.OnItemClickListener {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position,
                    long id) {
                // display view for selected nav drawer item
                displayView(position);
            }
        }

        @Override
        public boolean onCreateOptionsMenu(Menu menu) {
            getMenuInflater().inflate(R.menu.main, menu);
            return true;
        }

        @Override
        public boolean onOptionsItemSelected(MenuItem item) {
            // toggle nav drawer on selecting action bar app icon/title
            if (mDrawerToggle.onOptionsItemSelected(item)) {
                return true;
            }
            // Handle action bar actions click
            switch (item.getItemId()) {
            case R.id.action_settings:
                return true;
            default:
                return super.onOptionsItemSelected(item);
            }
        }

        /***
         * Called when invalidateOptionsMenu() is triggered
         */
        @Override
        public boolean onPrepareOptionsMenu(Menu menu) {
            // if nav drawer is opened, hide the action items
            boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);
            menu.findItem(R.id.action_settings).setVisible(!drawerOpen);
            return super.onPrepareOptionsMenu(menu);
        }

        /**
         * Diplaying fragment view for selected nav drawer list item
         * */
        private void displayView(int position) {
            // update the main content by replacing fragments
            Fragment fragment = null;
            switch (position) {
            case 0:
                fragment = new HomeFragment();
                break;
            case 1:
                fragment = new FindPeopleFragment();
                break;
            case 2:
                fragment = new PhotosFragment();
                break;
            case 3:
                fragment = new CommunityFragment();
                break;
            case 4:
                fragment = new PagesFragment();
                break;
            case 5:
                fragment = new WhatsHotFragment();
                break;

            default:
                break;
            }

            if (fragment != null) {
                FragmentManager fragmentManager = getFragmentManager();
                fragmentManager.beginTransaction()
                        .replace(R.id.frame_container, fragment).commit();

                // update selected item and title, then close the drawer
                mDrawerList.setItemChecked(position, true);
                mDrawerList.setSelection(position);
                setTitle(navMenuTitles[position]);
                mDrawerLayout.closeDrawer(mDrawerList);
            } else {
                // error in creating fragment
                Log.e("MainActivity", "Error in creating fragment");
            }
        }

        @Override
        public void setTitle(CharSequence title) {
            mTitle = title;
            getActionBar().setTitle(mTitle);
        }

        /**
         * When using the ActionBarDrawerToggle, you must call it during
         * onPostCreate() and onConfigurationChanged()...
         */

        @Override
        protected void onPostCreate(Bundle savedInstanceState) {
            super.onPostCreate(savedInstanceState);
            // Sync the toggle state after onRestoreInstanceState has occurred.
            mDrawerToggle.syncState();
        }

        @Override
        public void onConfigurationChanged(Configuration newConfig) {
            super.onConfigurationChanged(newConfig);
            // Pass any configuration change to the drawer toggls
            mDrawerToggle.onConfigurationChanged(newConfig);
        }

    }
