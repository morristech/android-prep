Android文本时钟 – Part 6
========================

在前一篇文章里，我们修正了我们应用小部件的外观上的一些小问题。接下来，我们将扩展我们的应用小部件来包括一些有关Android新版本的功能，同时维护它的向后兼容性。

我们要做的第一件事，是将我们的小部件添加到锁屏界面中。Android
4.2版本中引入了添加小部件到锁屏界面的功能，实际上实现这个过程非常容易。所有需要做的只是添加几行代码到`res/xml/appwidget-info.xml：`


    <?xml version="1.0" encoding="UTF-8"?>
     
    
     
    <appwidget-provider
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:minWidth="110dp"
        android:minHeight="40dp"
        android:updatePeriodMillis="86400000"
        android:initialLayout="@layout/appwidget"
        android:previewImage="@drawable/widget"
        android:resizeMode="none"
        android:widgetCategory="home_screen|keyguard"
        android:initialKeyguardLayout="@layout/appwidget">
    </appwidget-provider>


所有这些都是4.2版本的新功能，老版本对此会完全忽略。因此我们不需要做任何事情就可以保持软件的向后兼容性。

`widgetCategory`
属性让我们指定我们将提供哪一种小部件。在我们的例子中，我们提供一个标准的主屏幕小部件，但同时一个键盘锁(keyguard)小部件将出现在锁屏界面里。Android
4.2版本设备的默认值只是home\_screen，所以默认情况没有键盘锁属性。

`initialKeyguardLayout`
属性让我们指定我们在锁屏界面中想用的布局。一开始，我们使用和主屏幕小部件同样的布局。

如果启动应用，现在可以在锁屏界面下向左滑动来添加锁屏界面小部件，按下“+”按钮，然后从从备选小部件列表中选择文本时钟。

![select-lockscreen](http://blog.stylingandroid.com/wp-content/uploads/2013/02/select-lockscreen.png)

添加完成后，我们的锁屏界面看起来像这样：

![lockscreen-initial](http://blog.stylingandroid.com/wp-content/uploads/2013/02/lockscreen-initial.png)

这样就好了，但显示的时间有在边框处有一些变淡，因此我们应该让它更大一些。事实上，我们不需要像在主屏幕上那样将它同其它部件分开，因此我们可以将所有的背景去除。我们可以提供一个分离的布局在`res/layout/keyguard.xml`：

    <?xml version="1.0" encoding="utf-8"?>
     
    
     
    <LinearLayout
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:orientation="vertical"
        android:layout_width="fill_parent"
        android:layout_height="fill_parent">
     
        <TextView
            android:layout_width="match_parent"
            android:layout_height="0dp"
            android:layout_weight="1"
            style="@style/hoursTextKeyguard"
            android:gravity="bottom"
            android:id="@+id/hours"/>
     
        <TextView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            style="@style/minutesTextKeyguard"
            android:layout_marginTop="-10dp"
            android:layout_marginBottom="-10dp"
            android:id="@+id/tens"/>
     
        <TextView
            android:layout_width="match_parent"
            android:layout_height="0dp"
            android:layout_weight="1"
            style="@style/minutesTextKeyguard"
            android:id="@+id/minutes"/>
    </LinearLayout>

这同时需要添加一些新的样式：

    <?xml version="1.0" encoding="utf-8"?>
    
    <resources>
     
        <style name="hoursTextWidget">
            <item name="android:textSize">@dimen/widget_text_height</style></item>
            <item name="android:textColor">@color/holo_blue_bright</item>
            <item name="android:textStyle">bold</item>
        </style>
     
        <style name="minutesTextWidget" parent="hoursTextWidget">
            <item name="android:textColor">@color/holo_blue_light</style></item>
            <item name="android:textStyle">normal</item>
        </style>
     
        <style name="hoursTextKeyguard" parent="hoursTextWidget">
            <item name="android:textSize">36sp</style></item>
        </style>
     
        <style name="minutesTextKeyguard" parent="hoursTextKeyguard">
            <item name="android:textColor">@android:color/holo_blue_light</style></item>
            <item name="android:textStyle">normal</item>
        </style>
    </resources>        

如果设备上可用，我们希望使用Roboto
Light，因此我们需要改变`res/values-v16/styles.xml`的内容:

    <?xml version="1.0" encoding="utf-8"?>
    
    <resources>
     
        <style name="minutesTextWidget" parent="hoursTextWidget">
            <item name="android:textColor">@android:color/holo_blue_light</style></item>
            <item name="android:textStyle">normal</item>
            <item name="android:fontFamily">sans-serif-light</item>
        </style>
     
        <style name="minutesTextKeyguard" parent="hoursTextKeyguard">
            <item name="android:textColor">@android:color/holo_blue_light</style></item>
            <item name="android:textStyle">normal</item>
            <item name="android:fontFamily">sans-serif-light</item>
        </style>
    </resources>

我们同时需要改变`res/xml/appwidget-info.xml`的内容来使用这个新布局：

    <?xml version="1.0" encoding="utf-8"?>
     
    
     
    <appwidget-provider
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:minWidth="110dp"
        android:minHeight="40dp"
        android:updatePeriodMillis="86400000"
        android:initialLayout="@layout/appwidget"
        android:previewImage="@drawable/widget"
        android:resizeMode="none"
        android:widgetCategory="home_screen|keyguard"
        android:initialKeyguardLayout="@layout/keyguard">
    </appwidget-provider>


当我们设置这个初始布局，因为`TextClockService`
类的`updateTime()`方法的这行代码，当小部件更新时，我们会有一个问题：

    RemoteViews v = new RemoteViews( getPackageName(), R.layout.appwidget );

它会在每次小部件更新时应用主屏幕布局。所幸我们可以在更新时检查小部件的类型，然后使用适当地布局：

    private static final int WIDGET_CATEGORY_KEYGUARD = 2;
     
    private void updateTime( Calendar date )
    {
        Log.d( TAG, "Update: " + dateFormat.format( date.getTime() ) );
        AppWidgetManager manager = AppWidgetManager.getInstance( this );
        ComponentName name = new ComponentName( this, TextClockAppWidget.class );
        int[] appIds = manager.getAppWidgetIds( name );
        String[] words = TimeToWords.timeToWords( date );
        for ( int id : appIds )
        {
            Bundle options = manager.getAppWidgetOptions( id );
            int layoutId = R.layout.appwidget;
            if(options != null)
            {
                int type = options.getInt( "appWidgetCategory", 1 );
                if(type == WIDGET_CATEGORY_KEYGUARD)
                {
                    layoutId = R.layout.keyguard;
                }
            }
            RemoteViews v = new RemoteViews( getPackageName(), 
                layoutId);
            updateTime( words, v );
            manager.updateAppWidget( id, v );
        }
     
    }

对每一个小部件实例，我们从`AppWidgetManager`中获得的`AppWidgetOptions`
Bundle来确定它的类型。默认为类型1（表示是一个主屏幕小部件）。我们可以使用常量`AppWidgetProviderInfo.WIDGET_CATEGORY_KEYGUARD`来改进代码的可读性，而不是使用魔数2来表示
`WIDGET_CATEGORY_KEYGUARD` 常量，这实际上会破坏向后兼容性，因为 Android
常量从API 17里才开始引入，这样当在更早版本的环境上运行会发生错误。

再次运行，我们可以在锁屏界面里看到我们的新布局：

![lockscreen-correct](http://blog.stylingandroid.com/wp-content/uploads/2013/02/lockscreen-correct.png)

现在我们有一个锁屏界面小部件，它支持Android
4.2及以后版本的设备。这个版本的应用可以在Google
Play市场上找到对应的1.1.0版本。

下一个文章里我们要学习用Android 4.2的另一个新特性来扩展引用。

本文的代码可以从这里获取，TextClock应用可以从Google Play下载。

© 2013, Mark Allison. All rights reserved. This article originally
appeared on Styling Android.
