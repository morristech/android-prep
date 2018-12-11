[![androidhive](http://www.androidhive.info/wp-content/themes/androidhive_v2_analytics/img/logo.png)](http://www.androidhive.info)

June 30, 2013 08:15 PM

Android Working with XML Animations
===================================

Adding animations to your app interface will give high quality feel to
your android applications. Animations can be performed through either
XML or android code. In this tutorial i explained how to do animations
using XML notations. I will explain how to do the same using android
java code in future tutorials. Here i covered basic android animations
like fade in, fade out, scale, rotate, slide up, slide down etc.,

[![Download Code](http://www.androidhive.info/wp-content/uploads/2011/08/download_btn.png "Download Code")](http://download.androidhive.info/download?code=hwhC5G9eeWyJnM0hp63QkibLkj5cqpoFZC0KLRTzCbXa4362eewHTUq2MNImloyVa1qWQr9gnUYjtpCay97dF37kE2WDNE3ZHxerNQMCiG4aWgBiTnbHoZXNA%3D%3Dou9gDnDIN3DqfCnkb1W0eFpqQ4DUxscn7f5)

This image is for thumbnail purpose only  
 ![android animations using xml](http://www.androidhive.info/wp-content/uploads/2013/06/android-animations-banner.png)

In the source code project provided in this tutorial, I wrote separate
activity and XML for each animation. Download and play with the code to
get familiar with the animations. Following are list of animations
covered in this article.  
   

![android animations using xml](http://www.androidhive.info/wp-content/uploads/2013/06/android-animations-using-xml.png)

  

### Basic steps to perform animation

Following are the basic steps to perform an animation on any UI element.
Creating animation is very simple, all it needs is creating necessary
files and write small pieces of code.

  

### Step 1: Create xml that defines the animation

**** Create an xml file which defines type of animation to perform. This
file should be located under *anim* folder under *res* directory (*res ⇒
anim ⇒ animation.xml*). If you don’t have anim folder in your res
directory create one. Following is example of simple fade in animation.

![android animation anim folder](http://www.androidhive.info/wp-content/uploads/2013/06/android_anim_folder.png)

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true" >

        <alpha
            android:duration="1000"
            android:fromAlpha="0.0"
            android:interpolator="@android:anim/accelerate_interpolator"
            android:toAlpha="1.0" />

    </set>

### Step 2: Load the animation

Next in your activity create an object of
[Animation](http://developer.android.com/reference/android/view/animation/Animation.html)
class. And load the xml animation using
[AnimationUtils](http://developer.android.com/reference/android/view/animation/AnimationUtils.html)
by calling *loadAnimation* function.

    public class FadeInActivity extends Activity{

        TextView txtMessage;

        // Animation
        Animation animFadein;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_fadein);

            txtMessage = (TextView) findViewById(R.id.txtMessage);

            // load the animation
            animFadein = AnimationUtils.loadAnimation(getApplicationContext(),
                    R.anim.fade_in);        
        }
    }

### Step 3: Set the animation listeners (Optional)

If you want to listen to animation events like start, end and repeat,
your activity should implements
[AnimationListener](http://developer.android.com/reference/android/view/animation/Animation.AnimationListener.html).
This step is optional. If you implement AnimationListener you will have
to override following methods.

*onAnimationStart* – This will be triggered once the animation started  
 *onAnimationEnd* – This will be triggered once the animation is over  
 *onAnimationRepeat* – This will be triggered if the animation repeats

    public class FadeInActivity extends Activity implements AnimationListener {
    .
    .
    .
    // set animation listener
    animFadein.setAnimationListener(this);
    .
    .
    .
    // animation listeners
        @Override
        public void onAnimationEnd(Animation animation) {
            // Take any action after completing the animation
            // check for fade in animation
            if (animation == animFadein) {
                Toast.makeText(getApplicationContext(), "Animation Stopped",
                        Toast.LENGTH_SHORT).show();
            }

        }

        @Override
        public void onAnimationRepeat(Animation animation) {
            // Animation is repeating
        }

        @Override
        public void onAnimationStart(Animation animation) {
            // Animation started
        }

### Step 4: Finally start the animation

You can start animation whenever you want by calling *startAnimation* on
any UI element by passing the type of animation. In this example i am
calling fade in animation on TextView.

    // start the animation
    txtMessage.startAnimation(animFadein);

### Complete Code

Following is complete code for FadeInActivity

    package info.androidhive.androidanimations;

    import android.app.Activity;
    import android.os.Bundle;
    import android.view.View;
    import android.view.animation.Animation;
    import android.view.animation.AnimationUtils;
    import android.view.animation.Animation.AnimationListener;
    import android.widget.Button;
    import android.widget.TextView;
    import android.widget.Toast;

    public class FadeInActivity extends Activity implements AnimationListener {

        TextView txtMessage;
        Button btnStart;

        // Animation
        Animation animFadein;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            // TODO Auto-generated method stub
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_fadein);

            txtMessage = (TextView) findViewById(R.id.txtMessage);
            btnStart = (Button) findViewById(R.id.btnStart);

            // load the animation
            animFadein = AnimationUtils.loadAnimation(getApplicationContext(),
                    R.anim.fade_in);
            
            // set animation listener
            animFadein.setAnimationListener(this);

            // button click event
            btnStart.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    txtMessage.setVisibility(View.VISIBLE);
                    
                    // start the animation
                    txtMessage.startAnimation(animFadein);
                }
            });

        }

        @Override
        public void onAnimationEnd(Animation animation) {
            // Take any action after completing the animation

            // check for fade in animation
            if (animation == animFadein) {
                Toast.makeText(getApplicationContext(), "Animation Stopped",
                        Toast.LENGTH_SHORT).show();
            }

        }

        @Override
        public void onAnimationRepeat(Animation animation) {
            // TODO Auto-generated method stub

        }

        @Override
        public void onAnimationStart(Animation animation) {
            // TODO Auto-generated method stub

        }

    }

  

### Important XML animation attributes

When working with animations it is better to have through knowledge
about some of the important XML attributes which create major
differentiation in animation behavior. Following are the important
attributes you must known about.

*android:duration* – Duration of the animation in which the animation
should complete

*android:startOffset* – It is the waiting time before an animation
starts. This property is mainly used to perform multiple animations in a
sequential manner

*android:interpolator* – It is the rate of change in animation

*android:fillAfter* – This defines whether to apply the animation
transformation after the animation completes or not. If it sets to false
the element changes to its previous state after the animation. This
attribute should be use with *\<set\>* node

*android:repeatMode* – This is useful when you want your animation to be
repeat

*android:repeatCount* – This defines number of repetitions on animation.
If you set this value to *infinite* then animation will repeat infinite
times

  

### Some useful animations

Following i am giving xml code to perform lot of useful animations. Try
to assign different values to xml attributes to see change in
animations.

1. [Fade In](#fade_in)  
2. [Fade Out](#fade_out)  
3. [Cross Fading](#cross_fade)  
4. [Blink](#blink)  
5. [Zoom In](#zoom_in)  
6. [Zoom Out](#zoom_out)  
7. [Rotate](#rotate)  
8. [Move](#move)  
9. [Slide Up](#slide_up)  
10. [Slide Down](#slide_down)  
11. [Bounce](#bounce)  
12. [Sequential Animation](#sequential)  
13. [Together Animation](#together)

  

### Fade In

For fade in animation you can use *\<alpha\>* tag which defines alpha
value. Fade in animation is nothing but increasing alpha value from 0 to
1.

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true" >

        <alpha
            android:duration="1000"
            android:fromAlpha="0.0"
            android:interpolator="@android:anim/accelerate_interpolator"
            android:toAlpha="1.0" />

    </set>

  

### Fade Out

Fade out is exactly opposite to fade in, where we need to decrease the
alpha value from 1 to 0

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true" >

        <alpha
            android:duration="1000"
            android:fromAlpha="1.0"
            android:interpolator="@android:anim/accelerate_interpolator"
            android:toAlpha="0.0" />

    </set>

  

### Cross Fading

Cross fading is performing fade in animation while other element is
fading out. For this you don’t have to create separate animation file,
you can just use *fade\_in.xml* and *fade\_out.xml* files.

In the following code i loaded fade in and fade out, then performed them
on two different UI elements.

    TextView txtView1, txtView2;
    Animation animFadeIn, animFadeOut;
    .
    .
    // load animations
    animFadeIn = AnimationUtils.loadAnimation(getApplicationContext(),
                    R.anim.fade_in);
    animFadeOut = AnimationUtils.loadAnimation(getApplicationContext(),
                    R.anim.fade_out);
    .
    .
    // set animation listeners
    animFadeIn.setAnimationListener(this);
    animFadeOut.setAnimationListener(this);

    .
    .
    // Make fade in elements Visible first
    txtMessage2.setVisibility(View.VISIBLE);

    // start fade in animation
    txtMessage2.startAnimation(animFadeIn);
                    
    // start fade out animation
    txtMessage1.startAnimation(animFadeOut);

  

### Blink

Blink animation is animating fade out or fade in animation in repetitive
fashion. For this you will have to set *android:repeatMode=”reverse”*
and *android:repeatCount* attributes.

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android">
        <alpha android:fromAlpha="0.0"
            android:toAlpha="1.0"
            android:interpolator="@android:anim/accelerate_interpolator"
            android:duration="600"
            android:repeatMode="reverse"
            android:repeatCount="infinite"/>
    </set>

  

### Zoom In

For zoom use *\<scale\>* tag. Use *pivotX=”50%”* and *pivotY=”50%”* to
perform zoom from the center of the element. Also you need to use
*fromXScale*, *fromYScale* attributes which defines scaling of the
object. Keep these value lesser than *toXScale*, *toYScale*

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true" >

        <scale
            xmlns:android="http://schemas.android.com/apk/res/android"
            android:duration="1000"
            android:fromXScale="1"
            android:fromYScale="1"
            android:pivotX="50%"
            android:pivotY="50%"
            android:toXScale="3"
            android:toYScale="3" >
        </scale>

    </set>

  

### Zoom Out

Zoom out animation is same as zoom in but *toXScale*, *toYScale* values
are lesser than *fromXScale*, *fromYScale*

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true" >

        <scale
            xmlns:android="http://schemas.android.com/apk/res/android"
            android:duration="1000"
            android:fromXScale="1.0"
            android:fromYScale="1.0"
            android:pivotX="50%"
            android:pivotY="50%"
            android:toXScale="0.5"
            android:toYScale="0.5" >
        </scale>

    </set>

  

### Rotate

Rotate animation uses *\<rotate\>* tag. For rotate animation required
tags are *android:fromDegrees* and *android:toDegrees* which defines
rotation angles.

*Clock wise* – use positive toDegrees value  
 *Anti clock wise* – use negative toDegrees value

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android">
        <rotate android:fromDegrees="0"
            android:toDegrees="360"
            android:pivotX="50%"
            android:pivotY="50%"
            android:duration="600"
            android:repeatMode="restart"
            android:repeatCount="infinite"
            android:interpolator="@android:anim/cycle_interpolator"/>

    </set>

  

### Move

In order to change position of object use *\<translate\>* tag. It uses
*fromXDelta*, *fromYDelta* for X-direction and *toXDelta*, *toYDelta*
attributes for Y-direction.

    <?xml version="1.0" encoding="utf-8"?>
    <set
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:interpolator="@android:anim/linear_interpolator"
        android:fillAfter="true">

       <translate
            android:fromXDelta="0%p"
            android:toXDelta="75%p"
            android:duration="800" />
    </set>

  

### Slide Up

Sliding animation uses *\<scale\>* tag only. Slide up can be achieved by
setting*android:fromYScale=”1.0″* and *android:toYScale=”0.0″*

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true" >

        <scale
            android:duration="500"
            android:fromXScale="1.0"
            android:fromYScale="1.0"
            android:interpolator="@android:anim/linear_interpolator"
            android:toXScale="1.0"
            android:toYScale="0.0" />

    </set>

  

### Slide Down

Slide down is exactly opposite to slide down animation. Just interchange
*android:fromYScale* and *android:toYScale* values.

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true">

        <scale
            android:duration="500"
            android:fromXScale="1.0"
            android:fromYScale="0.0"
            android:interpolator="@android:anim/linear_interpolator"
            android:toXScale="1.0"
            android:toYScale="1.0" />

    </set>

  

### Bounce

Bounce is just an animation effect where animation ends in bouncing
fashion. For this set *android:interpolator* value to
*@android:anim/bounce\_interpolator*. This bounce can be used with any
kind animation. Following slide down example uses bounce effect.

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true"
        android:interpolator="@android:anim/bounce_interpolator">

        <scale
            android:duration="500"
            android:fromXScale="1.0"
            android:fromYScale="0.0"
            android:toXScale="1.0"
            android:toYScale="1.0" />

    </set>

  

### Sequential Animation

If you want to perform multiple animation in a sequential manner you
have to use *android:startOffset* to give start delay time. The easy way
to calculate this value is to *add the duration and startOffset* values
of previous animation. Following is a sequential animation where set of
move animations performs in sequential manner.

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true"
        android:interpolator="@android:anim/linear_interpolator" >

        <!-- Use startOffset to give delay between animations -->


        <!-- Move -->
        <translate
            android:duration="800"
            android:fillAfter="true"
            android:fromXDelta="0%p"
            android:startOffset="300"
            android:toXDelta="75%p" />
        <translate
            android:duration="800"
            android:fillAfter="true"
            android:fromYDelta="0%p"
            android:startOffset="1100"
            android:toYDelta="70%p" />
        <translate
            android:duration="800"
            android:fillAfter="true"
            android:fromXDelta="0%p"
            android:startOffset="1900"
            android:toXDelta="-75%p" />
        <translate
            android:duration="800"
            android:fillAfter="true"
            android:fromYDelta="0%p"
            android:startOffset="2700"
            android:toYDelta="-70%p" />

        <!-- Rotate 360 degrees -->
        <rotate
            android:duration="1000"
            android:fromDegrees="0"
            android:interpolator="@android:anim/cycle_interpolator"
            android:pivotX="50%"
            android:pivotY="50%"
            android:startOffset="3800"
            android:repeatCount="infinite"
            android:repeatMode="restart"
            android:toDegrees="360" />

    </set>

  

### Together Animation

Performing all animation together is just writing all animations one by
one without using *android:startOffset*

    <?xml version="1.0" encoding="utf-8"?>
    <set xmlns:android="http://schemas.android.com/apk/res/android"
        android:fillAfter="true"
        android:interpolator="@android:anim/linear_interpolator" >

        <scale
            xmlns:android="http://schemas.android.com/apk/res/android"
            android:duration="4000"
            android:fromXScale="1"
            android:fromYScale="1"
            android:pivotX="50%"
            android:pivotY="50%"
            android:toXScale="4"
            android:toYScale="4" >
        </scale>

        <!-- Rotate 180 degrees -->
        <rotate
            android:duration="500"
            android:fromDegrees="0"
            android:pivotX="50%"
            android:pivotY="50%"
            android:repeatCount="infinite"
            android:repeatMode="restart"
            android:toDegrees="360" />

    </set>

  

I hope you like this tutorial, feel free to ask any kind of questions in
the comment section.

Thank You

