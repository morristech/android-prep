[![androidhive](http://www.androidhive.info/wp-content/themes/androidhive_v2_analytics/img/logo.png)](http://www.androidhive.info)

October 6, 2013 06:21 PM

Android Tab Layout with Swipeable Views
=======================================
My previous article explains about [Android Tab
Layout](http://www.androidhive.info/2011/08/android-tab-layout-tutorial/)
and it got very good ranking in search engines. But unfortunately
TabHost is deprecated by android in favor of fragments. So it is
suggested that use fragment to achieve tab layout.

This article shows you how to create tab layout using fragments and
viewpager. Also you can swipe between tab view as it is the
functionality of viewpager which is not possible when using TabHost.

[DOWNLOAD
CODE](http://download.androidhive.info/download?code=qeJU2G3FRJTT072E9ynoVj4SMOUinAyN3cM1BSTv%2FbA6DHWQJlyVSMLQWgq%2FyUV%2Fl7MBRrKs6X7F6M7Yy15Kq2f2E9OI98hMTaEcu%2FvifOtMgP%2BUYhpbSrYfw%3D%3D5qW0JIiqMdOThVn2XFQJaLmyijjgR1x8Q0N)


![Android Tab Layout with Swipeable
Views](http://www.androidhive.info/wp-content/uploads/2013/10/tabs-with-swipe-views-banner.png)

  

ViewPager and Fragments
-----------------------

Before getting into this tutorial it is suggested to have knowledge on
[Fragments](http://developer.android.com/guide/components/fragments.html)
and
[ViewPager](http://developer.android.com/reference/android/support/v4/view/ViewPager.html)
as these two are main concepts used here. Unfortunately I haven’t
covered about fragements and viewpager on androidhive
![:(](http://www.androidhive.info/wp-includes/images/smilies/icon_sad.gif)

  

Layout Overview
---------------

Checkout the following pic which explains the complete overview of
layout architecture. Basically we are using **ViewPager** as main layout
and for individual pager views we use **Fragments**. The tabs are part
of Action Bar.

![android tab layout with swipeable
views](http://www.androidhive.info/wp-content/uploads/2013/10/Tabs-Illustration.jpg)

  

Creating new Project
--------------------

Even though you are not familiar with ViewPager or Fragments, don’t
worry. You will get an idea about what those are and how to use them
once you are done through this article. So let’s start by creating a new
project.

**1**. Create a new project in Eclipse from **File ⇒ New ⇒ Android ⇒
Application Project**. While creating the project select the app theme
which has Action Bar as shown in the below image.

![android tabs with swipe
gesture](http://www.androidhive.info/wp-content/uploads/2013/10/android-tabs-with-swipe-creating-project.png)

**2**. As we are going to use Fragments, **extend** your main activity
from *FragmentActivity*. Also **implement** this class from
*ActionBar.TabListener* as we are adding Tabs too.

    public class MainActivity extends FragmentActivity implements
            ActionBar.TabListener {

**3**. Open main activity layout file and add *ViewPager* element. (My
layout file for main activity is **activity\_main.xml**)

    <android.support.v4.view.ViewPager xmlns:android="http://schemas.android.com/apk/res/android"
        android:id="@+id/pager"
        android:layout_width="match_parent"
        android:layout_height="match_parent">
    </android.support.v4.view.ViewPager>

**4**. I normally prefer to create a separate package for adapter
classes just to separate them from activity classes. So create a new
package named your\_package\_name.adapter. I named my new package as
**info.androidhive.tabsswipe.adapter**

**5**. I am creating a *FragmentPagerAdapter* class to provide views to
tab fragments. Create a class called **TabsPagerAdapter.java** under
adapter package. This adapter provides fragment views to tabs which we
are going to create them later in this tutorial.

    package info.androidhive.tabsswipe.adapter;

    import info.androidhive.tabsswipe.GamesFragment;
    import info.androidhive.tabsswipe.MoviesFragment;
    import info.androidhive.tabsswipe.TopRatedFragment;
    import android.support.v4.app.Fragment;
    import android.support.v4.app.FragmentManager;
    import android.support.v4.app.FragmentPagerAdapter;

    public class TabsPagerAdapter extends FragmentPagerAdapter {

        public TabsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int index) {

            switch (index) {
            case 0:
                // Top Rated fragment activity
                return new TopRatedFragment();
            case 1:
                // Games fragment activity
                return new GamesFragment();
            case 2:
                // Movies fragment activity
                return new MoviesFragment();
            }

            return null;
        }

        @Override
        public int getCount() {
            // get item count - equal to number of tabs
            return 3;
        }

    }

  

Adding Tabs to Action Bar
-------------------------

**6**. In order to display tabs we don’t have to use any other UI
element like **TabHost**. Action bar has the inbuilt capability of
adding tabs. All we have to do is enable it using
**setNavigationMode(ActionBar.NAVIGATION\_MODE\_TABS)** method. Open
your **MainActivity.java** do the following.

Here I am adding three tabs **Top Rated**, **Games**, **Movies** to
action bar. So I just stored all the tab names in a String array and
added them to action bar using a for loop.

    public class MainActivity extends FragmentActivity implements
            ActionBar.TabListener {

        private ViewPager viewPager;
        private TabsPagerAdapter mAdapter;
        private ActionBar actionBar;
        // Tab titles
        private String[] tabs = { "Top Rated", "Games", "Movies" };

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            // Initilization
            viewPager = (ViewPager) findViewById(R.id.pager);
            actionBar = getActionBar();
            mAdapter = new TabsPagerAdapter(getSupportFragmentManager());

            viewPager.setAdapter(mAdapter);
            actionBar.setHomeButtonEnabled(false);
            actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);        

            // Adding Tabs
            for (String tab_name : tabs) {
                actionBar.addTab(actionBar.newTab().setText(tab_name)
                        .setTabListener(this));
            }

If you run the project, you can see the tabs displaying under action
bar.

![android action bar adding
tabs](http://www.androidhive.info/wp-content/uploads/2013/10/android-tabs-adding-to-action-bar.png)

  

Adding Views for Tabs
---------------------

We already returned respected fragments for tabs in the adapter class.
To make it simple I am creating very simple layout for each tab and
leaving it to you to build your own UI depending on your requirement.
For now I just displayed a label in the view with some background
color.  
   

» First Tab View
----------------

**7**. The first tab I added is **Top Rated**. Create a new layout file
under **src ⇒ res** folder named **fragment\_top\_rated.xml** and paste
the following code.

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:background="#fa6a6a" >
        
        <TextView android:layout_width="fill_parent"
            android:layout_height="wrap_content"
            android:gravity="center"
            android:text="Design Top Rated Screen"
            android:textSize="20dp"
            android:layout_centerInParent="true"/>
        

    </RelativeLayout>

**8**. Also create respected Fragment activity class for this view.
Create a new class named **TopRatedFragment.java** under your main
package.

    package info.androidhive.tabsswipe;

    import info.androidhive.tabsswipe.R;
    import android.os.Bundle;
    import android.support.v4.app.Fragment;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;

    public class TopRatedFragment extends Fragment {

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {

            View rootView = inflater.inflate(R.layout.fragment_top_rated, container, false);
            
            return rootView;
        }
    }

  

» Second Tab View
-----------------

The second tab in the list is **Games**. Just like above create a layout
file and activity file for this tab.

**9**. Create a new layout file under **src ⇒ res** folder named
**fragment\_games.xml**

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:background="#ff8400" >
        
        <TextView android:layout_width="fill_parent"
            android:layout_height="wrap_content"
            android:gravity="center"
            android:text="Design Games Screen"
            android:textSize="20dp"
            android:layout_centerInParent="true"/>
        

    </RelativeLayout>

**10**. Create a new class named **GamesFragment.java** with following
code.

    package info.androidhive.tabsswipe;

    import info.androidhive.tabsswipe.R;
    import android.os.Bundle;
    import android.support.v4.app.Fragment;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;

    public class GamesFragment extends Fragment {

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {

            View rootView = inflater.inflate(R.layout.fragment_games, container, false);
            
            return rootView;
        }
    }

  

» Third Tab View
----------------

This third tab is **Movies**. This one need a layout file and activity
class.

**11**. Create a layout file called **fragment\_movies.xml**

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical" 
        android:background="#17df0d">
        
        <TextView android:layout_width="fill_parent"
            android:layout_height="wrap_content"
            android:gravity="center"
            android:text="Design Movies Screen"
            android:textSize="20dp"
            android:layout_centerInParent="true"/>
        

    </RelativeLayout>

**12**. Also create activity class for this view named
**MoviesFragment.java**

    package info.androidhive.tabsswipe;

    import info.androidhive.tabsswipe.R;
    import android.os.Bundle;
    import android.support.v4.app.Fragment;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;

    public class MoviesFragment extends Fragment {

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {

            View rootView = inflater.inflate(R.layout.fragment_movies, container, false);
            
            return rootView;
        }

    }

Run the project and check whether the views for tabs are added or not.

![Android Tab Layout with Swipeable
Views](http://www.androidhive.info/wp-content/uploads/2013/10/Android-Tab-Layout-with-Swipeable-Views.png)

And this is how it looks in landscape mode

![Android-Tab-Layout-with-Swipeable-Views-landscape](http://www.androidhive.info/wp-content/uploads/2013/10/Android-Tab-Layout-with-Swipeable-Views-landscape.png)

  

Tab Change Listener
-------------------

If you run the project you can see the swiping views working, but if you
select a tab, view won’t change automatically. This is because ViewPager
didn’t know about the tab change event. We have to manually change the
view using Tab change listener.

**13**. In your **MainActivity.java** class add following code.

    @Override
        public void onTabReselected(Tab tab, FragmentTransaction ft) {
        }

        @Override
        public void onTabSelected(Tab tab, FragmentTransaction ft) {
            // on tab selected
            // show respected fragment view
            viewPager.setCurrentItem(tab.getPosition());
        }

        @Override
        public void onTabUnselected(Tab tab, FragmentTransaction ft) {
        }

  

View Change Listener
--------------------

**14**. As well if you swipe the view, you can’t see respected tab
selected. Here also using ViewPager **setOnPageChangeListener()** we
have to select the respected tab manually.

            /**
             * on swiping the viewpager make respective tab selected
             * */
            viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {

                @Override
                public void onPageSelected(int position) {
                    // on changing the page
                    // make respected tab selected
                    actionBar.setSelectedNavigationItem(position);
                }

                @Override
                public void onPageScrolled(int arg0, float arg1, int arg2) {
                }

                @Override
                public void onPageScrollStateChanged(int arg0) {
                }
            });

After adding these two listeners, if you run the project you can see
everything working good.

  

Complete Code
-------------

Below is the complete code for **MainActivity.java** class

    package info.androidhive.tabsswipe;

    import info.androidhive.tabsswipe.adapter.TabsPagerAdapter;
    import info.androidhive.tabsswipe.R;
    import android.app.ActionBar;
    import android.app.ActionBar.Tab;
    import android.app.FragmentTransaction;
    import android.os.Bundle;
    import android.support.v4.app.FragmentActivity;
    import android.support.v4.view.ViewPager;
    import android.view.Menu;

    public class MainActivity extends FragmentActivity implements
            ActionBar.TabListener {

        private ViewPager viewPager;
        private TabsPagerAdapter mAdapter;
        private ActionBar actionBar;
        // Tab titles
        private String[] tabs = { "Top Rated", "Games", "Movies" };

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            // Initilization
            viewPager = (ViewPager) findViewById(R.id.pager);
            actionBar = getActionBar();
            mAdapter = new TabsPagerAdapter(getSupportFragmentManager());

            viewPager.setAdapter(mAdapter);
            actionBar.setHomeButtonEnabled(false);
            actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);        

            // Adding Tabs
            for (String tab_name : tabs) {
                actionBar.addTab(actionBar.newTab().setText(tab_name)
                        .setTabListener(this));
            }

            /**
             * on swiping the viewpager make respective tab selected
             * */
            viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {

                @Override
                public void onPageSelected(int position) {
                    // on changing the page
                    // make respected tab selected
                    actionBar.setSelectedNavigationItem(position);
                }

                @Override
                public void onPageScrolled(int arg0, float arg1, int arg2) {
                }

                @Override
                public void onPageScrollStateChanged(int arg0) {
                }
            });
        }

        @Override
        public void onTabReselected(Tab tab, FragmentTransaction ft) {
        }

        @Override
        public void onTabSelected(Tab tab, FragmentTransaction ft) {
            // on tab selected
            // show respected fragment view
            viewPager.setCurrentItem(tab.getPosition());
        }

        @Override
        public void onTabUnselected(Tab tab, FragmentTransaction ft) {
        }

    }

