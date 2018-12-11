[![androidhive](http://www.androidhive.info/wp-content/themes/androidhive_v2_analytics/img/logo.png)](http://www.androidhive.info)

July 7, 2013 07:49 AM

How to implement Android Splash Screen
======================================
Android splash screen are normally used to show user some kind of
progress before the app loads completely. Some people uses splash screen
just to show case their app / company logo for a couple of second.
Unfortunately in android we don’t have any inbuilt mechanism to show
splash screen compared to iOS. In this tutorial we are going to learn
how to implement splash screen in your android application.

[![Download Code](http://www.androidhive.info/wp-content/uploads/2011/08/download_btn.png "Download Code")](http://download.androidhive.info/download?code=7VE724xKrLkwSDdRQbe3KbuFooiOl4PKoPT7L7GhwoiDbWvPgYZt13Nx697GGn5wklJcYpk8iyPKQe1UuLCLOxj15MrD9UrDZbV1VIS4vaGP2%2BqYvlS4N7bog%3D%3DtabHgsNNVERCR8i78r5Ij9Hl8KS2evmWA6h)

This image is for thumbnail purpose only  
 ![android splash screen](http://www.androidhive.info/wp-content/uploads/2013/06/android-splash-screen.png)

  

### Splash screen use case scenarios

The purpose of splash screen depends upon the app requirement. Check out
the following diagram which gives explanation about two use case
scenarios.

![android splash screen use case scenarios](http://www.androidhive.info/wp-content/uploads/2013/06/android-splash-screen-types.png)

In this tutorial I’ll be covering implementation of splash screen in two
scenarios. One is showing splash screen using a timer and second is
showing splash screen when making network http calls which takes some
time to fetch required information. Both the tutorial are same except
the splash screen activity.

In order to implement splash screen we are going to create a separate
activity for splash and once it closes we launch our main activity.

So let’s get started by creating a new project

  

### 1. Android Splash Screen Using Timer

**1**. Create a new project in Eclipse by navigating to **File ⇒ New
Android ⇒ Application Project** and fill required details. (I kept my
main activity name as *MainActivity.java*)

**2**. For Splash Screen we are creating a separate activity. Create a
new class in your package and name it as *SplashScreen.java*

**3**. Open your your *AndroidManifest.xml* file and make your splash
screen activity as Launcher activity.

    <?xml version="1.0" encoding="utf-8"?>
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="info.androidhive.androidsplashscreentimer"
        android:versionCode="1"
        android:versionName="1.0" >

        <uses-sdk
            android:minSdkVersion="8"
            android:targetSdkVersion="17" />

        <application
            android:allowBackup="true"
            android:icon="@drawable/ic_launcher"
            android:label="@string/app_name"
            android:theme="@style/AppTheme" >
            <!-- Splash screen -->
            <activity
                android:name="info.androidhive.androidsplashscreentimer.SplashScreen"
                android:label="@string/app_name"
                android:screenOrientation="portrait"
                android:theme="@android:style/Theme.Black.NoTitleBar" >
                <intent-filter>
                    <action android:name="android.intent.action.MAIN" />

                    <category android:name="android.intent.category.LAUNCHER" />
                </intent-filter>
            </activity>
            
            <!-- Main activity -->
            <activity
                android:name="info.androidhive.androidsplashscreentimer.MainActivity"
                android:label="@string/app_name" >
            </activity>
        </application>

    </manifest>

  
  
 **4**. Create a layout file for splash screen under *res ⇒ layout*
folder. I named the layout file as *activity\_splash.xml*. This layout
normally contains your app logo or company logo.

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@drawable/gradient_background" >

        <ImageView
            android:id="@+id/imgLogo"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerInParent="true"
            android:src="@drawable/wwe_logo" />

        <TextView
            android:layout_width="fill_parent"
            android:layout_height="wrap_content"
            android:layout_marginBottom="10dp"
            android:textSize="12dp"
            android:textColor="#454545"
            android:gravity="center_horizontal"
            android:layout_alignParentBottom="true"
            android:text="www.androidhive.info" />

    </RelativeLayout>

  
  
 **5**. Add the following code in *SplashScreen.java* activity. In this
following code a handler is used to wait for specific time and once the
timer is out we launched main activity.

    package info.androidhive.androidsplashscreentimer;

    import android.app.Activity;
    import android.content.Intent;
    import android.os.Bundle;
    import android.os.Handler;

    public class SplashScreen extends Activity {

        // Splash screen timer
        private static int SPLASH_TIME_OUT = 3000;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_splash);

            new Handler().postDelayed(new Runnable() {

                /*
                 * Showing splash screen with a timer. This will be useful when you
                 * want to show case your app logo / company
                 */

                @Override
                public void run() {
                    // This method will be executed once the timer is over
                    // Start your app main activity
                    Intent i = new Intent(SplashScreen.this, MainActivity.class);
                    startActivity(i);

                    // close this activity
                    finish();
                }
            }, SPLASH_TIME_OUT);
        }

    }

  

![android splash screen output](http://www.androidhive.info/wp-content/uploads/2013/06/android_splash_screen_design.jpg)

Run the application, you will see the splash screen for 3 sec and then
your main activity will be launched.

  
  
 Following is the second scenario where our app is going to make some
network calls before entering into app. Here every thing is same as
previous case except the *SplashScreen.java* code. In splash screen
activity in *onCreate* method we will calls a *AsyncTask* method which
fetch required information by making http call. Once the http call
terminates we launch main activity in *onPostExecute()* method.

  

### 2. Android Splash Screen When Making Network (http) Calls

**1**. Follow the same steps as above until creation of
*SplashScreen.java*

**2**. After that the first step is add INTERNET permission in the
manifest file as this app going to use internet. Open your
*AndroidManifest.xml* file and add *INTERNET* permission above
*\<application\>* tag

    <uses-permission android:name="android.permission.INTERNET"/>

**3**. Open your *SplashScreen.java* and add *AsyncTask* to make http
calls. In this tutorial i am making an http call to get json and
displayed on the log in screen. After fetching the json the data will be
sent to *MainActivity.java* using *Intents*.

Following is the json i am going to fetch. You can access this json from
[http://api.androidhive.info/game/game\_stats.json](http://api.androidhive.info/game/game_stats.json)

    {
        "game_stat":{
            "now_playing" : "49500",
            "earned" : "$65000"
        }
        .
        .
        .

Paste the following code in **SplashScreen.java**

    package info.androidhive.androidsplashscreentimer;

    import info.androidhive.androidsplashscreennetwork.R;
    import info.androidhive.network.JsonParser;

    import org.json.JSONException;
    import org.json.JSONObject;

    import android.app.Activity;
    import android.content.Intent;
    import android.os.AsyncTask;
    import android.os.Bundle;
    import android.util.Log;

    public class SplashScreen extends Activity {

        String now_playing, earned;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_splash);

            /**
             * Showing splashscreen while making network calls to download necessary
             * data before launching the app Will use AsyncTask to make http call
             */
            new PrefetchData().execute();

        }

        /**
         * Async Task to make http call
         */
        private class PrefetchData extends AsyncTask<Void, Void, Void> {

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                // before making http calls         

            }

            @Override
            protected Void doInBackground(Void... arg0) {
                /*
                 * Will make http call here This call will download required data
                 * before launching the app 
                 * example: 
                 * 1. Downloading and storing in SQLite 
                 * 2. Downloading images 
                 * 3. Fetching and parsing the xml / json 
                 * 4. Sending device information to server 
                 * 5. etc.,
                 */
                JsonParser jsonParser = new JsonParser();
                String json = jsonParser
                        .getJSONFromUrl("http://api.androidhive.info/game/game_stats.json");

                Log.e("Response: ", "> " + json);

                if (json != null) {
                    try {
                        JSONObject jObj = new JSONObject(json)
                                .getJSONObject("game_stat");
                        now_playing = jObj.getString("now_playing");
                        earned = jObj.getString("earned");

                        Log.e("JSON", "> " + now_playing + earned);

                    } catch (JSONException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }

                }

                return null;
            }

            @Override
            protected void onPostExecute(Void result) {
                super.onPostExecute(result);
                // After completing http call
                // will close this activity and lauch main activity
                Intent i = new Intent(SplashScreen.this, MainActivity.class);
                i.putExtra("now_playing", now_playing);
                i.putExtra("earned", earned);
                startActivity(i);

                // close this activity
                finish();
            }

        }

    }

**4**. On your *MainActivity.java* take appropriate action using parsed
json data. I just displayed on log in screen.

    package info.androidhive.androidsplashscreentimer;

    import info.androidhive.androidsplashscreennetwork.R;
    import android.app.Activity;
    import android.content.Intent;
    import android.os.Bundle;
    import android.view.View;
    import android.widget.LinearLayout;
    import android.widget.TextView;

    public class MainActivity extends Activity {

        LinearLayout llStats;
        TextView txtPlayCount, txtEarned;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            llStats = (LinearLayout) findViewById(R.id.llStats);
            txtPlayCount = (TextView) findViewById(R.id.txtNowPlaying);
            txtEarned = (TextView) findViewById(R.id.txtEarned);

            // layout background transparent
            llStats.getBackground().setAlpha(150);
            llStats.setVisibility(View.VISIBLE);

            Intent i = getIntent();
            String now_playing = i.getStringExtra("now_playing");
            String earned = i.getStringExtra("earned");

            // Diplaying the text
            txtPlayCount.setText(now_playing);
            txtEarned.setText(earned);
        }
    }

  

![android splash screen when making http](http://www.androidhive.info/wp-content/uploads/2013/06/android-splash-screen-network-http.jpg)

I provided two separate project in the source code of this tutorial,
download and go through the code to get clear picture of the concept.

