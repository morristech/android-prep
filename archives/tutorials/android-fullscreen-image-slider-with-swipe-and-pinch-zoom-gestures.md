[![androidhive](http://www.androidhive.info/wp-content/themes/androidhive_v2_analytics/img/logo.png)](http://www.androidhive.info)

September 1, 2013 08:23 PM

Android Fullscreen Image Slider with Swipe and Pinch Zoom Gestures
==================================================================
This tutorial explains how to build your own image gallery browser in
your android applications with swipe and pinch zooming functionality.
This article is combination of three separate concepts such as Grid
View, Swiping and Pinch Gesture in one project.

I already covered Grid View previously. Refer [Android GridView Layout Tutorial](http://www.androidhive.info/2012/02/android-gridview-layout-tutorial/)
incase if you are new to Grid View.

[DOWNLOAD CODE](http://download.androidhive.info/download?code=KKQBSdTDnrDlLv1XaAAOFJByIs4OAOOVFW5iXnHhMER3XT9NjvewzHRESGdE66dWju9%2F%2F8a%2BRVmbltXYExgmX1aUd4a4GGSJ%2B46h1DvQP6AoYBAEMThsiCHmzQXYd1ctNrSZTn8HgJZ7CN0S6lHqmQzzsQkW3qqgaVtuvbzdxuiarjUoXtF5Z54YTlU5oyZ9gZwNh1)

VIDEO DEMO

![android full screen image slider with swipe gesture](http://www.androidhive.info/wp-content/uploads/2013/09/android-full-screen-image-slider-with-swipe-gesture.jpg)

This project is divided in to three tasks. First one is building Grid
View display of all the images. Second is showing selected grid image in
full screen slider. And finally adding pinch zooming functionality to
fullscreen image.

  
  
 Let’s start with creating a new project

Creating new project
--------------------

**1**. Create new project in Eclipse IDE from **File ⇒ New ⇒ Android
Application Project** and fill all the required details. I kept my
package name as *info.androidhive.imageslider* and main activity name as
*GridViewActivity.java*  
   

#### App Constant Class

I am creating a app constant class file to store static variables which
will be used across application. In this way you don’t have modify much
code if you want to change app configuration.

**2**. In order to maintaining good project structure I am creating a
separate package for storing this kind of helper classes. **Right click
on src ⇒ New ⇒ Package** and name it as
**your\_package\_name.helper**.  
 (So my helper package becomes *info.androidhive.imageslider.helper*)

**3**. Under helper package create a new class named *AppConstant.java*
and paste the following code. In the following I declared required
constant variables

*NUM\_OF\_COLUMNS* – Number of columns to be displayed in Grid view  
 *PHOTO\_ALBUM* – Name of the photo album directory in the sd card. Make
sure that you have some images inside this directory before you start
the project.  
 *FILE\_EXTN* – Image file extensions to be supported

    package info.androidhive.imageslider.helper;

    import java.util.Arrays;
    import java.util.List;

    public class AppConstant {

        // Number of columns of Grid View
        public static final int NUM_OF_COLUMNS = 3;

        // Gridview image padding
        public static final int GRID_PADDING = 8; // in dp

        // SD card image directory
        public static final String PHOTO_ALBUM = "androidhive";

        // supported file formats
        public static final List<String> FILE_EXTN = Arrays.asList("jpg", "jpeg",
                "png");
    }

  

#### Helper Utils Class

**4**. I am creating another class to define reusable functions across
applications. Create another class under helper package named
*Utils.java*

Following are major functions defined in Utils class

*getFilePaths()* – This function will return all image paths of a
directory  
 *IsSupportedFile()* – This will check for supported file extensions

    package info.androidhive.imageslider.helper;

    import java.io.File;
    import java.util.ArrayList;
    import java.util.Locale;

    import android.app.AlertDialog;
    import android.content.Context;
    import android.graphics.Point;
    import android.view.Display;
    import android.view.WindowManager;
    import android.widget.Toast;

    public class Utils {

        private Context _context;

        // constructor
        public Utils(Context context) {
            this._context = context;
        }

        // Reading file paths from SDCard
        public ArrayList<String> getFilePaths() {
            ArrayList<String> filePaths = new ArrayList<String>();

            File directory = new File(
                    android.os.Environment.getExternalStorageDirectory()
                            + File.separator + AppConstant.PHOTO_ALBUM);

            // check for directory
            if (directory.isDirectory()) {
                // getting list of file paths
                File[] listFiles = directory.listFiles();

                // Check for count
                if (listFiles.length > 0) {

                    // loop through all files
                    for (int i = 0; i < listFiles.length; i++) {

                        // get file path
                        String filePath = listFiles[i].getAbsolutePath();

                        // check for supported file extension
                        if (IsSupportedFile(filePath)) {
                            // Add image path to array list
                            filePaths.add(filePath);
                        }
                    }
                } else {
                    // image directory is empty
                    Toast.makeText(
                            _context,
                            AppConstant.PHOTO_ALBUM
                                    + " is empty. Please load some images in it !",
                            Toast.LENGTH_LONG).show();
                }

            } else {
                AlertDialog.Builder alert = new AlertDialog.Builder(_context);
                alert.setTitle("Error!");
                alert.setMessage(AppConstant.PHOTO_ALBUM
                        + " directory path is not valid! Please set the image directory name AppConstant.java class");
                alert.setPositiveButton("OK", null);
                alert.show();
            }

            return filePaths;
        }

        // Check supported file extensions
        private boolean IsSupportedFile(String filePath) {
            String ext = filePath.substring((filePath.lastIndexOf(".") + 1),
                    filePath.length());

            if (AppConstant.FILE_EXTN
                    .contains(ext.toLowerCase(Locale.getDefault())))
                return true;
            else
                return false;

        }

        /*
         * getting screen width
         */
        public int getScreenWidth() {
            int columnWidth;
            WindowManager wm = (WindowManager) _context
                    .getSystemService(Context.WINDOW_SERVICE);
            Display display = wm.getDefaultDisplay();

            final Point point = new Point();
            try {
                display.getSize(point);
            } catch (java.lang.NoSuchMethodError ignore) { // Older device
                point.x = display.getWidth();
                point.y = display.getHeight();
            }
            columnWidth = point.x;
            return columnWidth;
        }
    }

  

Displaying thumbnail images in Grid View
----------------------------------------

Until now we are done with some utility functions which required
further. So let’s start first view of the application which is
displaying images in grid view.

**5**. Create a new layout file under **res ⇒ layout** folder named
*activity\_grid\_view.xml* and paste the following code

    <?xml version="1.0" encoding="utf-8"?>
    <GridView xmlns:android="http://schemas.android.com/apk/res/android"
        android:id="@+id/grid_view"
        android:layout_width="fill_parent"
        android:layout_height="fill_parent"
        android:numColumns="auto_fit"
        android:gravity="center"
        android:stretchMode="columnWidth"
        android:background="#000000"> 
    </GridView>

#### GridView Adapter

I am creating a custom grid adapter class for the grid view. In this way
you can create a reusable view for the grid view blocks. As this class
is not an activity class I prefer to keep it in another package.

**6**. Create another package named **adapter** under **src** folder. I
created another package named *info.androidhive.imageslider.adapter*

**7**. Under adapter package create a class file named
*GridViewImageAdapter.java* and extend it from *BaseAdapter* This
adapter class simply returns image view to gridview.

    package info.androidhive.imageslider.adapter;

    import info.androidhive.imageslider.FullScreenViewActivity;

    import java.io.File;
    import java.io.FileInputStream;
    import java.io.FileNotFoundException;
    import java.util.ArrayList;

    import android.app.Activity;
    import android.content.Intent;
    import android.graphics.Bitmap;
    import android.graphics.BitmapFactory;
    import android.view.View;
    import android.view.View.OnClickListener;
    import android.view.ViewGroup;
    import android.widget.BaseAdapter;
    import android.widget.GridView;
    import android.widget.ImageView;

    public class GridViewImageAdapter extends BaseAdapter {

        private Activity _activity;
        private ArrayList<String> _filePaths = new ArrayList<String>();
        private int imageWidth;

        public GridViewImageAdapter(Activity activity, ArrayList<String> filePaths,
                int imageWidth) {
            this._activity = activity;
            this._filePaths = filePaths;
            this.imageWidth = imageWidth;
        }

        @Override
        public int getCount() {
            return this._filePaths.size();
        }

        @Override
        public Object getItem(int position) {
            return this._filePaths.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            ImageView imageView;
            if (convertView == null) {
                imageView = new ImageView(_activity);
            } else {
                imageView = (ImageView) convertView;
            }

            // get screen dimensions
            Bitmap image = decodeFile(_filePaths.get(position), imageWidth,
                    imageWidth);

            imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            imageView.setLayoutParams(new GridView.LayoutParams(imageWidth,
                    imageWidth));
            imageView.setImageBitmap(image);

            // image view click listener
            imageView.setOnClickListener(new OnImageClickListener(position));

            return imageView;
        }

        class OnImageClickListener implements OnClickListener {

            int _postion;

            // constructor
            public OnImageClickListener(int position) {
                this._postion = position;
            }

            @Override
            public void onClick(View v) {
                // on selecting grid view image
                // launch full screen activity
                Intent i = new Intent(_activity, FullScreenViewActivity.class);
                i.putExtra("position", _postion);
                _activity.startActivity(i);
            }

        }

        /*
         * Resizing image size
         */
        public static Bitmap decodeFile(String filePath, int WIDTH, int HIGHT) {
            try {

                File f = new File(filePath);

                BitmapFactory.Options o = new BitmapFactory.Options();
                o.inJustDecodeBounds = true;
                BitmapFactory.decodeStream(new FileInputStream(f), null, o);

                final int REQUIRED_WIDTH = WIDTH;
                final int REQUIRED_HIGHT = HIGHT;
                int scale = 1;
                while (o.outWidth / scale / 2 >= REQUIRED_WIDTH
                        && o.outHeight / scale / 2 >= REQUIRED_HIGHT)
                    scale *= 2;

                BitmapFactory.Options o2 = new BitmapFactory.Options();
                o2.inSampleSize = scale;
                return BitmapFactory.decodeStream(new FileInputStream(f), null, o2);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            return null;
        }

    }

**8**. Finally open the activity class for grid view. In my case my grid
view activity name is *GridViewActivity.java*.

*InitilizeGridLayout()* – This will initialize the grid view layout by
setting necessary attributes like padding, number of columns, spacing
between grid images etc.,

    package info.androidhive.imageslider;

    import info.androidhive.imageslider.adapter.GridViewImageAdapter;
    import info.androidhive.imageslider.helper.AppConstant;
    import info.androidhive.imageslider.helper.Utils;

    import java.util.ArrayList;

    import android.app.Activity;
    import android.content.res.Resources;
    import android.os.Bundle;
    import android.util.TypedValue;
    import android.widget.GridView;

    public class GridViewActivity extends Activity {

        private Utils utils;
        private ArrayList<String> imagePaths = new ArrayList<String>();
        private GridViewImageAdapter adapter;
        private GridView gridView;
        private int columnWidth;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_grid_view);

            gridView = (GridView) findViewById(R.id.grid_view);

            utils = new Utils(this);

            // Initilizing Grid View
            InitilizeGridLayout();

            // loading all image paths from SD card
            imagePaths = utils.getFilePaths();

            // Gridview adapter
            adapter = new GridViewImageAdapter(GridViewActivity.this, imagePaths,
                    columnWidth);

            // setting grid view adapter
            gridView.setAdapter(adapter);
        }

        private void InitilizeGridLayout() {
            Resources r = getResources();
            float padding = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,
                    AppConstant.GRID_PADDING, r.getDisplayMetrics());

            columnWidth = (int) ((utils.getScreenWidth() - ((AppConstant.NUM_OF_COLUMNS + 1) * padding)) / AppConstant.NUM_OF_COLUMNS);

            gridView.setNumColumns(AppConstant.NUM_OF_COLUMNS);
            gridView.setColumnWidth(columnWidth);
            gridView.setStretchMode(GridView.NO_STRETCH);
            gridView.setPadding((int) padding, (int) padding, (int) padding,
                    (int) padding);
            gridView.setHorizontalSpacing((int) padding);
            gridView.setVerticalSpacing((int) padding);
        }

    }

Now run your project and test it once. You should see a grid view
displaying the images from the sd card. Following is the screenshot of
my grid view

![android grid view and fullscreen image slider](http://www.androidhive.info/wp-content/uploads/2013/09/android-grid-view-fullscreen-image-slider.jpg)

  

Creating Fullscreen Image Slider
--------------------------------

Second task in this tutorial is to build a fullscreen image slider for
the images displayed in the grid view. This also involves swiping
gesture to navigate through the album.

To create swiping gesture functionality I am using
[PagerAdapter](http://developer.android.com/reference/android/support/v4/view/PagerAdapter.html)
class provided by android.

**9**. Create an xml layout file for full screen activity. I created a
file called *activity\_fullscreen\_view.xml* under **res ⇒ layout**
folder. Add a *android.support.v4.view.ViewPager* element inside it.

    <?xml version="1.0" encoding="utf-8"?>
    <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical" >

        <android.support.v4.view.ViewPager
            android:id="@+id/pager"
            android:layout_width="fill_parent"
            android:layout_height="fill_parent" />

    </LinearLayout>

**10**. In fullscreen view instead of showing only fullview image you
might want to show some other UI elments like text, buttons along with
the image. So I created a separate layout for fullscreen view, so that
you can customize the fullscreen view in this layout file.

As of now I am just adding a close button over the image. Create an xml
layout file under **res ⇒ layout** folder named
*layout\_fullscreen\_image.xml* and add the following code

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent" >

        <ImageView
            android:id="@+id/imgDisplay"
            android:layout_width="fill_parent"
            android:layout_height="fill_parent"
            android:scaleType="fitCenter" />

        <Button
            android:id="@+id/btnClose"
            android:layout_width="wrap_content"
            android:layout_height="30dp"
            android:layout_alignParentRight="true"
            android:layout_alignParentTop="true"
            android:layout_marginRight="15dp"
            android:layout_marginTop="15dp"
            android:paddingTop="2dp"
            android:paddingBottom="2dp"
            android:background="@drawable/button_background"
            android:textColor="#ffffff"
            android:text="Close" />

    </RelativeLayout>

Also create a file called *button\_background.xml* under **drawable**
folder. This is just for styling the button

    <?xml version="1.0" encoding="utf-8"?>
    <shape xmlns:android="http://schemas.android.com/apk/res/android"
        android:shape="rectangle" >

        <corners android:radius="3dp" />

        <solid android:color="#000000" />

        <stroke
            android:width="2px"
            android:color="#ffffff" />

    </shape>

  

#### Fullscreen Image Viewer Adapter

Just like grid adapter, we are going to create another adapter for the
full screen activity too. This is the data provider for the fullscreen
image viewer.

**11**. Create another class under **adapter** package named
*FullScreenImageAdapter.java* and extend it from *PagerAdapter*.

    package info.androidhive.imageslider.adapter;

    import info.androidhive.imageslider.R;

    import java.util.ArrayList;

    import android.app.Activity;
    import android.content.Context;
    import android.graphics.Bitmap;
    import android.graphics.BitmapFactory;
    import android.support.v4.view.PagerAdapter;
    import android.support.v4.view.ViewPager;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;
    import android.widget.Button;
    import android.widget.ImageView;
    import android.widget.RelativeLayout;

    public class FullScreenImageAdapter extends PagerAdapter {

        private Activity _activity;
        private ArrayList<String> _imagePaths;
        private LayoutInflater inflater;

        // constructor
        public FullScreenImageAdapter(Activity activity,
                ArrayList<String> imagePaths) {
            this._activity = activity;
            this._imagePaths = imagePaths;
        }

        @Override
        public int getCount() {
            return this._imagePaths.size();
        }

        @Override
        public boolean isViewFromObject(View view, Object object) {
            return view == ((RelativeLayout) object);
        }
        
        @Override
        public Object instantiateItem(ViewGroup container, int position) {
            ImageView imgDisplay;
            Button btnClose;
     
            inflater = (LayoutInflater) _activity
                    .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            View viewLayout = inflater.inflate(R.layout.layout_fullscreen_image, container,
                    false);
     
            imgDisplay = (ImageView) viewLayout.findViewById(R.id.imgDisplay);
            btnClose = (Button) viewLayout.findViewById(R.id.btnClose);
            
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inPreferredConfig = Bitmap.Config.ARGB_8888;
            Bitmap bitmap = BitmapFactory.decodeFile(_imagePaths.get(position), options);
            imgDisplay.setImageBitmap(bitmap);
            
            // close button click event
            btnClose.setOnClickListener(new View.OnClickListener() {            
                @Override
                public void onClick(View v) {
                    _activity.finish();
                }
            });
     
            ((ViewPager) container).addView(viewLayout);
     
            return viewLayout;
        }
        
        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            ((ViewPager) container).removeView((RelativeLayout) object);
     
        }
    }

Also make sure that you have added *FullScreenViewActivity* to
*AndroidManifest.xml* file before testing your project.

    <?xml version="1.0" encoding="utf-8"?>
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="info.androidhive.imageslider"
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
            <activity
                android:name="info.androidhive.imageslider.GridViewActivity"
                android:theme="@android:style/Theme.Holo.NoActionBar">
                <intent-filter>
                    <action android:name="android.intent.action.MAIN" />

                    <category android:name="android.intent.category.LAUNCHER" />
                </intent-filter>
            </activity>
            
            <activity
                android:name="info.androidhive.imageslider.FullScreenViewActivity"
                android:theme="@android:style/Theme.Holo.NoActionBar">
            </activity>
        </application>

    </manifest>

Run your project once again and click on grid view image. You should see
fullscreen view of selected grid view image. Also swipe left or right to
cycle through album.

![android full screen image slider with swipe](http://www.androidhive.info/wp-content/uploads/2013/09/android-fullscreen-image-slider-with-swipe1.jpg)

  

Adding Pinch Zooming Functionality
----------------------------------

For pinching functionality instead of writing my own class from scratch,
I just borrowed the code from
[TouchImageView](https://github.com/MikeOrtiz/TouchImageView). Thanks to
[Michael Ortiz](https://github.com/MikeOrtiz) for writing such a
beautiful code
![:)](http://www.androidhive.info/wp-includes/images/smilies/icon_smile.gif)

Adding this class in your project needs very few modifications.

**12**. Create class in helper package named *TouchImageView.java* and
paste the following code.

    package info.androidhive.imageslider.helper;

    import android.content.Context;
    import android.graphics.Matrix;
    import android.graphics.PointF;
    import android.graphics.drawable.Drawable;
    import android.util.AttributeSet;
    import android.util.Log;
    import android.view.MotionEvent;
    import android.view.ScaleGestureDetector;
    import android.view.View;
    import android.widget.ImageView;

    public class TouchImageView extends ImageView {

        Matrix matrix;

        // We can be in one of these 3 states
        static final int NONE = 0;
        static final int DRAG = 1;
        static final int ZOOM = 2;
        int mode = NONE;

        // Remember some things for zooming
        PointF last = new PointF();
        PointF start = new PointF();
        float minScale = 1f;
        float maxScale = 3f;
        float[] m;

        int viewWidth, viewHeight;
        static final int CLICK = 3;
        float saveScale = 1f;
        protected float origWidth, origHeight;
        int oldMeasuredWidth, oldMeasuredHeight;

        ScaleGestureDetector mScaleDetector;

        Context context;

        public TouchImageView(Context context) {
            super(context);
            sharedConstructing(context);
        }

        public TouchImageView(Context context, AttributeSet attrs) {
            super(context, attrs);
            sharedConstructing(context);
        }

        private void sharedConstructing(Context context) {
            super.setClickable(true);
            this.context = context;
            mScaleDetector = new ScaleGestureDetector(context, new ScaleListener());
            matrix = new Matrix();
            m = new float[9];
            setImageMatrix(matrix);
            setScaleType(ScaleType.MATRIX);

            setOnTouchListener(new OnTouchListener() {

                @Override
                public boolean onTouch(View v, MotionEvent event) {
                    mScaleDetector.onTouchEvent(event);
                    PointF curr = new PointF(event.getX(), event.getY());

                    switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        last.set(curr);
                        start.set(last);
                        mode = DRAG;
                        break;

                    case MotionEvent.ACTION_MOVE:
                        if (mode == DRAG) {
                            float deltaX = curr.x - last.x;
                            float deltaY = curr.y - last.y;
                            float fixTransX = getFixDragTrans(deltaX, viewWidth,
                                    origWidth * saveScale);
                            float fixTransY = getFixDragTrans(deltaY, viewHeight,
                                    origHeight * saveScale);
                            matrix.postTranslate(fixTransX, fixTransY);
                            fixTrans();
                            last.set(curr.x, curr.y);
                        }
                        break;

                    case MotionEvent.ACTION_UP:
                        mode = NONE;
                        int xDiff = (int) Math.abs(curr.x - start.x);
                        int yDiff = (int) Math.abs(curr.y - start.y);
                        if (xDiff < CLICK && yDiff < CLICK)
                            performClick();
                        break;

                    case MotionEvent.ACTION_POINTER_UP:
                        mode = NONE;
                        break;
                    }

                    setImageMatrix(matrix);
                    invalidate();
                    return true; // indicate event was handled
                }

            });
        }

        public void setMaxZoom(float x) {
            maxScale = x;
        }

        private class ScaleListener extends
                ScaleGestureDetector.SimpleOnScaleGestureListener {
            @Override
            public boolean onScaleBegin(ScaleGestureDetector detector) {
                mode = ZOOM;
                return true;
            }

            @Override
            public boolean onScale(ScaleGestureDetector detector) {
                float mScaleFactor = detector.getScaleFactor();
                float origScale = saveScale;
                saveScale *= mScaleFactor;
                if (saveScale > maxScale) {
                    saveScale = maxScale;
                    mScaleFactor = maxScale / origScale;
                } else if (saveScale < minScale) {
                    saveScale = minScale;
                    mScaleFactor = minScale / origScale;
                }

                if (origWidth * saveScale <= viewWidth
                        || origHeight * saveScale <= viewHeight)
                    matrix.postScale(mScaleFactor, mScaleFactor, viewWidth / 2,
                            viewHeight / 2);
                else
                    matrix.postScale(mScaleFactor, mScaleFactor,
                            detector.getFocusX(), detector.getFocusY());

                fixTrans();
                return true;
            }
        }

        void fixTrans() {
            matrix.getValues(m);
            float transX = m[Matrix.MTRANS_X];
            float transY = m[Matrix.MTRANS_Y];

            float fixTransX = getFixTrans(transX, viewWidth, origWidth * saveScale);
            float fixTransY = getFixTrans(transY, viewHeight, origHeight
                    * saveScale);

            if (fixTransX != 0 || fixTransY != 0)
                matrix.postTranslate(fixTransX, fixTransY);
        }

        float getFixTrans(float trans, float viewSize, float contentSize) {
            float minTrans, maxTrans;

            if (contentSize <= viewSize) {
                minTrans = 0;
                maxTrans = viewSize - contentSize;
            } else {
                minTrans = viewSize - contentSize;
                maxTrans = 0;
            }

            if (trans < minTrans)
                return -trans + minTrans;
            if (trans > maxTrans)
                return -trans + maxTrans;
            return 0;
        }

        float getFixDragTrans(float delta, float viewSize, float contentSize) {
            if (contentSize <= viewSize) {
                return 0;
            }
            return delta;
        }

        @Override
        protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
            super.onMeasure(widthMeasureSpec, heightMeasureSpec);
            viewWidth = MeasureSpec.getSize(widthMeasureSpec);
            viewHeight = MeasureSpec.getSize(heightMeasureSpec);

            //
            // Rescales image on rotation
            //
            if (oldMeasuredHeight == viewWidth && oldMeasuredHeight == viewHeight
                    || viewWidth == 0 || viewHeight == 0)
                return;
            oldMeasuredHeight = viewHeight;
            oldMeasuredWidth = viewWidth;

            if (saveScale == 1) {
                // Fit to screen.
                float scale;

                Drawable drawable = getDrawable();
                if (drawable == null || drawable.getIntrinsicWidth() == 0
                        || drawable.getIntrinsicHeight() == 0)
                    return;
                int bmWidth = drawable.getIntrinsicWidth();
                int bmHeight = drawable.getIntrinsicHeight();

                Log.d("bmSize", "bmWidth: " + bmWidth + " bmHeight : " + bmHeight);

                float scaleX = (float) viewWidth / (float) bmWidth;
                float scaleY = (float) viewHeight / (float) bmHeight;
                scale = Math.min(scaleX, scaleY);
                matrix.setScale(scale, scale);

                // Center the image
                float redundantYSpace = (float) viewHeight
                        - (scale * (float) bmHeight);
                float redundantXSpace = (float) viewWidth
                        - (scale * (float) bmWidth);
                redundantYSpace /= (float) 2;
                redundantXSpace /= (float) 2;

                matrix.postTranslate(redundantXSpace, redundantYSpace);

                origWidth = viewWidth - 2 * redundantXSpace;
                origHeight = viewHeight - 2 * redundantYSpace;
                setImageMatrix(matrix);
            }
            fixTrans();
        }
    }

**13**. After adding the class open your *layout\_fullscreen\_image.xml*
file which used to display fullscreen image and modify *ImageView* to
*info.androidhive.imageslider.helper.TouchImageView* element.

    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent" >

        <info.androidhive.imageslider.helper.TouchImageView
            android:id="@+id/imgDisplay"
            android:layout_width="fill_parent"
            android:layout_height="fill_parent"
            android:scaleType="fitCenter" />

        <Button
            android:id="@+id/btnClose"
            android:layout_width="wrap_content"
            android:layout_height="30dp"
            android:layout_alignParentRight="true"
            android:layout_alignParentTop="true"
            android:layout_marginRight="15dp"
            android:layout_marginTop="15dp"
            android:paddingTop="2dp"
            android:paddingBottom="2dp"
            android:background="@drawable/button_background"
            android:textColor="#ffffff"
            android:text="Close" />

    </RelativeLayout>

**14**. In *FullScreenImageAdapter.java* class also we used *ImageView*.
Just replace this one with *TouchImageView*

    public class FullScreenImageAdapter extends PagerAdapter {
        .
        .
        .   
        @Override
        public Object instantiateItem(ViewGroup container, int position) {
            TouchImageView imgDisplay; // Replace here with TouchImageView
        .
        // this one too
            imgDisplay = (TouchImageView) viewLayout.findViewById(R.id.imgDisplay); // this one too
        .
        .
        .
     
            return viewLayout;
        }
    }

Run your project now and test the pinch zooming functionality.

#### Testing Pinch Zooming in Emulator

As of now Emulator is not supporting multi touch gesture. So you should
use real device to test the pinch zooming functionality

I know this project has some performance issues like grid scrolling is
little bit slow. Search and try to find a solution to make it better.

Happy Coding ….
![:)](http://www.androidhive.info/wp-includes/images/smilies/icon_smile.gif)

