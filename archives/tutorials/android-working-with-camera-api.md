[![androidhive](http://www.androidhive.info/wp-content/themes/androidhive_v2_analytics/img/logo.png)](http://www.androidhive.info)
September 29, 2013 06:27 AM

Android working with Camera
===========================

Now a days lot of apps offer users to take pictures and record videos
for various kind of purposes. This tutorial describes how to do the same
in your applications.

Integrating camera can be done in two ways. One is to use android
inbuilt camera app which is very easy process. This method won’t give
you much control over camera as everything is taken care by inbuilt
camera app. This way will be appropriate when your app need just a
picture or video from camera.

Second way is to build a custom camera interface and adding the
functionality. This needs higher effort as we have to do everything by
our own. Building custom camera interface will be useful when you are
building an app which mainly deals with images and videos like
Instagram.

This tutorial covers the first scenario which is using android in build
camera app in your application.

[DOWNLOAD CODE](http://download.androidhive.info/download?code=owWLTG8nJ9ArB0ARsVOM6Ne78WJnsn0X0lxYvIEMLHoLn4FGbDRAadkXNkGrOVqUQLd%2FiLXkFaaFBk%3DExV23yPa70CoTDaTuEXcFpxtj7T9GseNnXP)

![android working with camera
api](http://www.androidhive.info/wp-content/uploads/2013/09/android-working-with-camera-api.jpg)

  

Let’s start by creating a new project

**1**. Create a new project in Eclipse from **File ⇒ New ⇒ Android ⇒
Application Project** and fill all the required information. I left my
main activity as **MainActivity.java**

  

Adding Permissions / Features
-----------------------------

**2**. Working with camera needs set of permissions and features in the
**AndroidManifest.xml** file. Add following in your AndroidManifest.xml

*android.hardware.camera* – Required to use camera hardware  
 *WRITE\_EXTERNAL\_STORAGE* – Required to store images / video in
external storage  
 *RECORD\_AUDIO* – Needed when recording video with audio

    <?xml version="1.0" encoding="utf-8"?>
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="info.androidhive.androidcameraapi"
        android:versionCode="1"
        android:versionName="1.0" >

        <uses-sdk
            android:minSdkVersion="8"
            android:targetSdkVersion="17" />

        <!-- Accessing camera hardware -->
        <uses-feature android:name="android.hardware.camera" />

        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
        <uses-permission android:name="android.permission.RECORD_AUDIO" />

        <application
            android:allowBackup="true"
            android:icon="@drawable/ic_launcher"
            android:label="@string/app_name"
            android:theme="@style/AppTheme" >
            <activity
                android:name="info.androidhive.androidcameraapi.MainActivity"
                android:label="@string/app_name"
                android:configChanges="orientation|keyboard|keyboardHidden"
                android:screenOrientation="landscape">
                <intent-filter>
                    <action android:name="android.intent.action.MAIN" />

                    <category android:name="android.intent.category.LAUNCHER" />
                </intent-filter>
            </activity>
        </application>

    </manifest>

**3**. For demo purpose I have created a simple layout with two
*Buttons*, *ImageView* and *VideoView*. Open your layout file of your
main activity **activity\_main.xml** and paste the following code.

    <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="fill_parent"
        android:layout_height="fill_parent"
        android:orientation="horizontal"
        android:baselineAligned="false"
        tools:context=".MainActivity" >

        <LinearLayout
            android:layout_width="0dp"
            android:layout_height="fill_parent"
            android:layout_weight="1"
            android:gravity="center"
            android:orientation="vertical" >

            <!-- Capture picture button -->
            <Button
                android:id="@+id/btnCapturePicture"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="Take a Picture"
                android:layout_marginBottom="10dp"/>

            <!-- Record video button -->
            <Button
                android:id="@+id/btnRecordVideo"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="Record a Video" />
        </LinearLayout>

        <LinearLayout
            android:layout_width="0dp"
            android:layout_height="fill_parent"
            android:layout_weight="1"
            android:orientation="vertical"
            android:padding="10dp">

            <TextView
                android:layout_width="fill_parent"
                android:layout_height="wrap_content"
                android:text="Preview" 
                android:padding="10dp"
                android:textSize="15dp"/>

            <!-- To display picture taken -->
            <ImageView
                android:id="@+id/imgPreview"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:visibility="gone" />

            <!-- To preview video recorded -->
            <VideoView
                android:id="@+id/videoPreview"
                android:layout_width="wrap_content"
                android:layout_height="400dp"
                android:visibility="gone" />
        </LinearLayout>

    </LinearLayout>

**4**. In *MainActivity.java* I started with adding code like declaring
required variables, referencing the xml UI elements and adding button
click listeners.

I kept default location to store images and videos in **“Hello Camera”**
directory which will be created under SD card **Pictures/Hello Camera**

    public class MainActivity extends Activity {

        // Activity request codes
        private static final int CAMERA_CAPTURE_IMAGE_REQUEST_CODE = 100;
        private static final int CAMERA_CAPTURE_VIDEO_REQUEST_CODE = 200;
        public static final int MEDIA_TYPE_IMAGE = 1;
        public static final int MEDIA_TYPE_VIDEO = 2;

        // directory name to store captured images and videos
        private static final String IMAGE_DIRECTORY_NAME = "Hello Camera";

        private Uri fileUri; // file url to store image/video

        private ImageView imgPreview;
        private VideoView videoPreview;
        private Button btnCapturePicture, btnRecordVideo;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            imgPreview = (ImageView) findViewById(R.id.imgPreview);
            videoPreview = (VideoView) findViewById(R.id.videoPreview);
            btnCapturePicture = (Button) findViewById(R.id.btnCapturePicture);
            btnRecordVideo = (Button) findViewById(R.id.btnRecordVideo);

            /**
             * Capture image button click event
             * */
            btnCapturePicture.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    // capture picture
                    captureImage();
                }
            });

            /**
             * Record video button click event
             */
            btnRecordVideo.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    // record video
                    recordVideo();
                }
            });
        }
    }

  

Checking Camera Availability
----------------------------

**5**. You might think about the scenario if the device does’t have the
camera. So before using any camera feature, it is better to check
availability of the camera. This can be done in two ways

**a. Defining the camera feature in AndroidManifest.xml**

By adding *android.hardware.camera* feature in manifest file, Google
Play prevents the app to be installed on devices those doesn’t have
camera.

**b. Checking in code manually**  
 You can also do a check in the code.

    /**
         * Checking device has camera hardware or not
         * */
        private boolean isDeviceSupportCamera() {
            if (getApplicationContext().getPackageManager().hasSystemFeature(
                    PackageManager.FEATURE_CAMERA)) {
                // this device has a camera
                return true;
            } else {
                // no camera on this device
                return false;
            }
        }

  

Taking a Picture
----------------

**6**. As we are using android’s inbuilt camera app, launching the
camera and taking the picture can done with very few lines of code using
the power of *Intent*.

*MediaStore.ACTION\_IMAGE\_CAPTURE* – Requesting camera app to capture
image  
 *MediaStore.EXTRA\_OUTPUT* – Specifying a path where the image has to
be stored

*captureImage()* function will launch the camera to snap a picture.

         /*
         * Capturing Camera Image will lauch camera app requrest image capture
         */
        private void captureImage() {
            Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

            fileUri = getOutputMediaFileUri(MEDIA_TYPE_IMAGE);

            intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);

            // start the image capture Intent
            startActivityForResult(intent, CAMERA_CAPTURE_IMAGE_REQUEST_CODE);
        }

  

**7**. As we are starting an activity using *startActivityForResult()*,
we can expect some result in *onActivityResult()* method. Override this
method in your activity like below. We also can check whether the user
successfully took the picture or cancelled the camera.

        /**
         * Receiving activity result method will be called after closing the camera
         * */
        @Override
        protected void onActivityResult(int requestCode, int resultCode, Intent data) {
            // if the result is capturing Image
            if (requestCode == CAMERA_CAPTURE_IMAGE_REQUEST_CODE) {
                if (resultCode == RESULT_OK) {
                    // successfully captured the image
                    // display it in image view
                    previewCapturedImage();
                } else if (resultCode == RESULT_CANCELED) {
                    // user cancelled Image capture
                    Toast.makeText(getApplicationContext(),
                            "User cancelled image capture", Toast.LENGTH_SHORT)
                            .show();
                } else {
                    // failed to capture image
                    Toast.makeText(getApplicationContext(),
                            "Sorry! Failed to capture image", Toast.LENGTH_SHORT)
                            .show();
                }
            }
        }

![android launching camera
application](http://www.androidhive.info/wp-content/uploads/2013/09/android-working-with-camera.jpg)

  

Displaying Captured Image
-------------------------

As we used inbuilt camera app to capture the picture we won’t get the
image in **onActivityResult()** method. In this case **data** parameter
will be always null. We have to use **fileUri** to get the file path and
display the image

**8**. **onActivityResult()** we use
**CAMERA\_CAPTURE\_IMAGE\_REQUEST\_CODE** to check whether response came
from Image Capture activity or Video Capture acivity. Call
*previewCapturedImage()* in onActivityResult after doing this check.

    /*
         * Display image from a path to ImageView
         */
        private void previewCapturedImage() {
            try {
                // hide video preview
                videoPreview.setVisibility(View.GONE);

                imgPreview.setVisibility(View.VISIBLE);

                // bimatp factory
                BitmapFactory.Options options = new BitmapFactory.Options();

                // downsizing image as it throws OutOfMemory Exception for larger
                // images
                options.inSampleSize = 8;

                final Bitmap bitmap = BitmapFactory.decodeFile(fileUri.getPath(),
                        options);

                imgPreview.setImageBitmap(bitmap);
            } catch (NullPointerException e) {
                e.printStackTrace();
            }
        }

![android camera taking a
picture](http://www.androidhive.info/wp-content/uploads/2013/09/android-taking-picture-with-camera.jpg)

  

Recording a Video
-----------------

**9**. Launching camera to record video is same as capturing image. But
instead of **MediaStore.ACTION\_IMAGE\_CAPTURE** we use
*MediaStore.ACTION\_VIDEO\_CAPTURE*.

Here we also define video quality using
*MediaStore.EXTRA\_VIDEO\_QUALITY* flag. Keeping this value as **1**
records video at high quality with higher file size and keeping **0**
records the video at lower quality and lower file size.

Call following function on record video button click event

         /*
         * Recording video
         */
        private void recordVideo() {
            Intent intent = new Intent(MediaStore.ACTION_VIDEO_CAPTURE);

            fileUri = getOutputMediaFileUri(MEDIA_TYPE_VIDEO);

            // set video quality
            // 1- for high quality video
            intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 1);

            intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);

            // start the video capture Intent
            startActivityForResult(intent, CAMERA_CAPTURE_VIDEO_REQUEST_CODE);
        }

And in **onActivityResult()** method check the success of recording.

    /**
         * Receiving activity result method will be called after closing the camera
         * */
        @Override
        protected void onActivityResult(int requestCode, int resultCode, Intent data) {
            // if the result is capturing Image
            if (requestCode == CAMERA_CAPTURE_IMAGE_REQUEST_CODE) {
                // code to check capture image response
            } else if (requestCode == CAMERA_CAPTURE_VIDEO_REQUEST_CODE) {
                if (resultCode == RESULT_OK) {
                    // video successfully recorded
                    // preview the recorded video
                    previewVideo();
                } else if (resultCode == RESULT_CANCELED) {
                    // user cancelled recording
                    Toast.makeText(getApplicationContext(),
                            "User cancelled video recording", Toast.LENGTH_SHORT)
                            .show();
                } else {
                    // failed to record video
                    Toast.makeText(getApplicationContext(),
                            "Sorry! Failed to record video", Toast.LENGTH_SHORT)
                            .show();
                }
            }
        }

  

Previewing Recorded Video
-------------------------

**10**. Following function will play recorded video in **VideoView**.
Call this method in onActivityResult method after checking RESULT\_OK
for camera response

    /*
         * Previewing recorded video
         */
        private void previewVideo() {
            try {
                // hide image preview
                imgPreview.setVisibility(View.GONE);

                videoPreview.setVisibility(View.VISIBLE);
                videoPreview.setVideoPath(fileUri.getPath());
                // start playing
                videoPreview.start();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

  

Avoiding NullPointerException after taking camera picture
---------------------------------------------------------

**11**. It is known issue that everybody faces a
**NullPointerException** while working with inbuilt camera application.
When we launch the camera it actually restarts our activity which causes
*fileUri* to be null. So when we use fileUri to display captured image
or recorded video, we will get NullPointerException.

So in order to fix it we have to use *onSaveInstanceState()* and
*onRestoreInstanceState()* to retain *fileUri* value. Add following code
in **MainActivity.java**

        /**
         * Here we store the file url as it will be null after returning from camera
         * app
         */
        @Override
        protected void onSaveInstanceState(Bundle outState) {
            super.onSaveInstanceState(outState);

            // save file url in bundle as it will be null on scren orientation
            // changes
            outState.putParcelable("file_uri", fileUri);
        }

        /*
         * Here we restore the fileUri again
         */
        @Override
        protected void onRestoreInstanceState(Bundle savedInstanceState) {
            super.onRestoreInstanceState(savedInstanceState);

            // get the file url
            fileUri = savedInstanceState.getParcelable("file_uri");
        }

  

Helper Methods
--------------

**12**. Add following methods in your main activity class. These methods
helps in creating and getting files from SD card.

         /**
         * Creating file uri to store image/video
         */
        public Uri getOutputMediaFileUri(int type) {
            return Uri.fromFile(getOutputMediaFile(type));
        }

        /*
         * returning image / video
         */
        private static File getOutputMediaFile(int type) {

            // External sdcard location
            File mediaStorageDir = new File(
                    Environment
                            .getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                    IMAGE_DIRECTORY_NAME);

            // Create the storage directory if it does not exist
            if (!mediaStorageDir.exists()) {
                if (!mediaStorageDir.mkdirs()) {
                    Log.d(IMAGE_DIRECTORY_NAME, "Oops! Failed create "
                            + IMAGE_DIRECTORY_NAME + " directory");
                    return null;
                }
            }

            // Create a media file name
            String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss",
                    Locale.getDefault()).format(new Date());
            File mediaFile;
            if (type == MEDIA_TYPE_IMAGE) {
                mediaFile = new File(mediaStorageDir.getPath() + File.separator
                        + "IMG_" + timeStamp + ".jpg");
            } else if (type == MEDIA_TYPE_VIDEO) {
                mediaFile = new File(mediaStorageDir.getPath() + File.separator
                        + "VID_" + timeStamp + ".mp4");
            } else {
                return null;
            }

            return mediaFile;
        }

It is advisable to use a real device and test the application.

Final Code
----------

Here is the complete code of **MainActivity.java**

    package info.androidhive.androidcameraapi;

    import java.io.File;
    import java.text.SimpleDateFormat;
    import java.util.Date;
    import java.util.Locale;

    import android.app.Activity;
    import android.content.Intent;
    import android.content.pm.PackageManager;
    import android.graphics.Bitmap;
    import android.graphics.BitmapFactory;
    import android.net.Uri;
    import android.os.Bundle;
    import android.os.Environment;
    import android.provider.MediaStore;
    import android.util.Log;
    import android.view.View;
    import android.widget.Button;
    import android.widget.ImageView;
    import android.widget.Toast;
    import android.widget.VideoView;

    public class MainActivity extends Activity {

        // Activity request codes
        private static final int CAMERA_CAPTURE_IMAGE_REQUEST_CODE = 100;
        private static final int CAMERA_CAPTURE_VIDEO_REQUEST_CODE = 200;
        public static final int MEDIA_TYPE_IMAGE = 1;
        public static final int MEDIA_TYPE_VIDEO = 2;

        // directory name to store captured images and videos
        private static final String IMAGE_DIRECTORY_NAME = "Hello Camera";

        private Uri fileUri; // file url to store image/video

        private ImageView imgPreview;
        private VideoView videoPreview;
        private Button btnCapturePicture, btnRecordVideo;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            imgPreview = (ImageView) findViewById(R.id.imgPreview);
            videoPreview = (VideoView) findViewById(R.id.videoPreview);
            btnCapturePicture = (Button) findViewById(R.id.btnCapturePicture);
            btnRecordVideo = (Button) findViewById(R.id.btnRecordVideo);

            /**
             * Capture image button click event
             */
            btnCapturePicture.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    // capture picture
                    captureImage();
                }
            });

            /**
             * Record video button click event
             */
            btnRecordVideo.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    // record video
                    recordVideo();
                }
            });

            // Checking camera availability
            if (!isDeviceSupportCamera()) {
                Toast.makeText(getApplicationContext(),
                        "Sorry! Your device doesn't support camera",
                        Toast.LENGTH_LONG).show();
                // will close the app if the device does't have camera
                finish();
            }
        }

        /**
         * Checking device has camera hardware or not
         * */
        private boolean isDeviceSupportCamera() {
            if (getApplicationContext().getPackageManager().hasSystemFeature(
                    PackageManager.FEATURE_CAMERA)) {
                // this device has a camera
                return true;
            } else {
                // no camera on this device
                return false;
            }
        }

        /**
         * Capturing Camera Image will lauch camera app requrest image capture
         */
        private void captureImage() {
            Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

            fileUri = getOutputMediaFileUri(MEDIA_TYPE_IMAGE);

            intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);

            // start the image capture Intent
            startActivityForResult(intent, CAMERA_CAPTURE_IMAGE_REQUEST_CODE);
        }

        /**
         * Here we store the file url as it will be null after returning from camera
         * app
         */
        @Override
        protected void onSaveInstanceState(Bundle outState) {
            super.onSaveInstanceState(outState);

            // save file url in bundle as it will be null on scren orientation
            // changes
            outState.putParcelable("file_uri", fileUri);
        }

        @Override
        protected void onRestoreInstanceState(Bundle savedInstanceState) {
            super.onRestoreInstanceState(savedInstanceState);

            // get the file url
            fileUri = savedInstanceState.getParcelable("file_uri");
        }

        /**
         * Recording video
         */
        private void recordVideo() {
            Intent intent = new Intent(MediaStore.ACTION_VIDEO_CAPTURE);

            fileUri = getOutputMediaFileUri(MEDIA_TYPE_VIDEO);

            // set video quality
            intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 1);

            intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri); // set the image file
                                                                // name

            // start the video capture Intent
            startActivityForResult(intent, CAMERA_CAPTURE_VIDEO_REQUEST_CODE);
        }

        /**
         * Receiving activity result method will be called after closing the camera
         * */
        @Override
        protected void onActivityResult(int requestCode, int resultCode, Intent data) {
            // if the result is capturing Image
            if (requestCode == CAMERA_CAPTURE_IMAGE_REQUEST_CODE) {
                if (resultCode == RESULT_OK) {
                    // successfully captured the image
                    // display it in image view
                    previewCapturedImage();
                } else if (resultCode == RESULT_CANCELED) {
                    // user cancelled Image capture
                    Toast.makeText(getApplicationContext(),
                            "User cancelled image capture", Toast.LENGTH_SHORT)
                            .show();
                } else {
                    // failed to capture image
                    Toast.makeText(getApplicationContext(),
                            "Sorry! Failed to capture image", Toast.LENGTH_SHORT)
                            .show();
                }
            } else if (requestCode == CAMERA_CAPTURE_VIDEO_REQUEST_CODE) {
                if (resultCode == RESULT_OK) {
                    // video successfully recorded
                    // preview the recorded video
                    previewVideo();
                } else if (resultCode == RESULT_CANCELED) {
                    // user cancelled recording
                    Toast.makeText(getApplicationContext(),
                            "User cancelled video recording", Toast.LENGTH_SHORT)
                            .show();
                } else {
                    // failed to record video
                    Toast.makeText(getApplicationContext(),
                            "Sorry! Failed to record video", Toast.LENGTH_SHORT)
                            .show();
                }
            }
        }

        /**
         * Display image from a path to ImageView
         */
        private void previewCapturedImage() {
            try {
                // hide video preview
                videoPreview.setVisibility(View.GONE);

                imgPreview.setVisibility(View.VISIBLE);

                // bimatp factory
                BitmapFactory.Options options = new BitmapFactory.Options();

                // downsizing image as it throws OutOfMemory Exception for larger
                // images
                options.inSampleSize = 8;

                final Bitmap bitmap = BitmapFactory.decodeFile(fileUri.getPath(),
                        options);

                imgPreview.setImageBitmap(bitmap);
            } catch (NullPointerException e) {
                e.printStackTrace();
            }
        }

        /**
         * Previewing recorded video
         */
        private void previewVideo() {
            try {
                // hide image preview
                imgPreview.setVisibility(View.GONE);

                videoPreview.setVisibility(View.VISIBLE);
                videoPreview.setVideoPath(fileUri.getPath());
                // start playing
                videoPreview.start();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        /**
         * ------------ Helper Methods ---------------------- 
         * */

        /**
         * Creating file uri to store image/video
         */
        public Uri getOutputMediaFileUri(int type) {
            return Uri.fromFile(getOutputMediaFile(type));
        }

        /**
         * returning image / video
         */
        private static File getOutputMediaFile(int type) {

            // External sdcard location
            File mediaStorageDir = new File(
                    Environment
                            .getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                    IMAGE_DIRECTORY_NAME);

            // Create the storage directory if it does not exist
            if (!mediaStorageDir.exists()) {
                if (!mediaStorageDir.mkdirs()) {
                    Log.d(IMAGE_DIRECTORY_NAME, "Oops! Failed create "
                            + IMAGE_DIRECTORY_NAME + " directory");
                    return null;
                }
            }

            // Create a media file name
            String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss",
                    Locale.getDefault()).format(new Date());
            File mediaFile;
            if (type == MEDIA_TYPE_IMAGE) {
                mediaFile = new File(mediaStorageDir.getPath() + File.separator
                        + "IMG_" + timeStamp + ".jpg");
            } else if (type == MEDIA_TYPE_VIDEO) {
                mediaFile = new File(mediaStorageDir.getPath() + File.separator
                        + "VID_" + timeStamp + ".mp4");
            } else {
                return null;
            }

            return mediaFile;
        }
    }

