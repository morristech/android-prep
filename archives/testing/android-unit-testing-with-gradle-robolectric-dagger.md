[Android unit testing with Gradle, Robolectric, Dagger and Mockito](http://blog.flatstack.com/post/69670609763/android-unit-testing-with-gradle-robolectric-dagger)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

Not long ago I faced the problem of setting up [Gradle](http://tools.android.com/tech-docs/new-build-system), [Robolectric](http://robolectric.org/) and [Dagger](http://square.github.io/dagger/) for unit testing my app. And after tinkering a bit, I managed to make them all work together. In this tutorial I assume that you know how to work with Gradle, Robolectric, Dagger and [Mockito](https://code.google.com/p/mockito/) separately.

I’m just going to show that they can work together pretty neatly, and how can they make Android testing a lot easier

Wiring Robolectric and Gradle
-----------------------------

First of all, you’re going to need a fully set up Android project ready to be built with Gradle. And I’m assuming that you’re using default project layout (e.g. your java sources are located in `$projectDir/src/main/java/`)

For the next step we need to install a [Gradle Android test plugin](https://github.com/JakeWharton/gradle-android-test-plugin) to a local maven repository:

    git clone git@github.com:JakeWharton/gradle-android-test-plugin.git
    cd gradle-android-test-plugin
    ./gradlew install

Then we need to add it to our root buildscript, so your main `build.gradle` should look something like this:

    buildscript {
        repositories {
            mavenCentral()
            mavenLocal()
        }
        dependencies {
            classpath 'com.android.tools.build:gradle:+'
            classpath 'com.squareup.gradle:gradle-android-test-plugin:0.9.1-SNAPSHOT'
        }
    }
     
    allprojects {
        repositories {
            mavenCentral()
        }
    }

Next we need configure our project that will be tested: add test plugin and add test dependencies. Configure it’s `build.gradle` to look something like this:

    apply plugin: 'android'
    apply plugin: 'android-test'
     
    android {
        // your android plugin configuration here
    }
     
    dependencies {
        // your regular  dependencies here
        compile 'com.squareup.dagger:dagger-compiler:+'
        compile 'com.squareup.dagger:dagger:+'
        
        // test dependencies
        testCompile 'junit:junit:+'
        // note that currently this approach doesn't work
        // with Robolectric 2.2, so we're using 2.1 for now
        testCompile 'org.robolectric:robolectric:2.1.+'
        testCompile 'org.mockito:mockito-all:+'
    }

Last step would be to add a custom test runner for Gradle and annotate all your test’s `@RunWith()` with this class:

    public class RobolectricGradleTestRunner extends RobolectricTestRunner {
     
        public RobolectricGradleTestRunner(Class<?> testClass) throws InitializationError {
            super(testClass);
        }
     
        @Override
        protected AndroidManifest getAppManifest(Config config) {
            String manifestProperty = System.getProperty("android.manifest");
            if (config.manifest().equals(Config.DEFAULT) && manifestProperty != null) {
                String resProperty = System.getProperty("android.resources");
                String assetsProperty = System.getProperty("android.assets");
                return new AndroidManifest(Fs.fileFromPath(manifestProperty),
                        Fs.fileFromPath(resProperty),
                        Fs.fileFromPath(assetsProperty));
            }
            return super.getAppManifest(config);
        }
    }

So this is it, you just configured your project for unit testing with Gradle and Robolectric. Just run `gradle check` to run your tests. But now we need to somehow inject mock dependencies in our tests with Dagger (well, this should be the main reason to use it anyways).

Wiring Robolectric, Dagger and Mockito
--------------------------------------

A little theory: we create the `ObjectGraph` for our modules in our `Application` subclass, so we need to somehow replace the real modules with mock ones. Second thing: `Robolectric` allocates an `Application` class found in the `AndroidManifest.xml`, but we can override that behavour by simply appending ‘Test’ to the beginning of our `Application` subclass name.

For example, if you have it like `com.mycompany.myapp.MyApplication`, then you need to supply `com.mycompany.myapp.TestMyApplication` subclass for Robolectric. So here’s what we do. Our `Application` subclass should look like this:

    public class MyApplication extends Application {
     
        public static MyApplication from(Context context) {
            return (MyApplication) context.getApplicationContext();
        }
     
        ObjectGraph objectGraph;
     
        @Override
        public void onCreate() {
            super.onCreate();
            objectGraph = ObjectGraph.create(getModules().toArray());
        }
     
        public <T> T inject(T object) {
            return objectGraph.inject(object);
        }
     
        // we create a list containing the MyModule Dagger module
        // later we can add any other modules to it (for testing)
        protected List<Object> getModules() {
            List<Object> modules = new ArrayList<Object>(1);
            modules.add(new MyModule(this));
            return modules;
        }
    }

Then we need to create our test module, where we’ll be overriding production module with mocks:

    @Module(injects = {MyTest.class},
     
            // this is your production modules
            // that you're overriding
            includes = MyModule.class,
            
            // here you override all the real
            // objects with mocks
            overrides = true)
    public class TestModule {
     
        @Provides
        @Singleton
        CookieManager provideMockCookieManager() {
            return mock(CookieManager.class);
        }
    }

Then we need to create our `Application`'s subclass in the same package in the `test/java/` source folder:

    public class TestMyApplication extends MyApplication {
     
        @Override
        protected ArrayList<Object> getModules() {
            ArrayList<Object> modules = super.getModules();
            modules.add(new TestModule());
            return modules;
        }
     
        public static <T> T injectMocks(T object) {
            TestMyApplication app = (TestMyApplication) Robolectric.application;
            return app.inject(object);
        }
    }

Robolectric will now fire up the tests with the instance of this class, and it will be available at `Robolectric.application` static field.

The last part will be to actually write some tests. Here’s the real test from my application, where I mock the `CookieManager`, inject it in both my `Activity` and Test class instances, and then perform the testing:

    @RunWith(RobolectricGradleTestRunner.class)
    public class MainActivityTest {
     
        @Inject CookieManager cookieManager;
     
        @Before
        public void setUp() {
            injectMocks(this);
        }
     
        // tests if the same instance is injected in test and in Activity
        @Test
        public void testInjection() throws Exception {
            assertEquals(cookieManager, buildActivity(MainActivity.class).create().get().cookieManager);
        }
     
        // tests if Activity is finishing if there's no cookie for vk.com
        @Test
        public void testLoggedOut() throws Exception {
            when(cookieManager.getCookie("vk.com")).thenReturn(null);
            assertTrue(buildActivity(MainActivity.class).create().get().isFinishing());
        }
    }

Yeah, that was pretty cumbersome, but you can wrap this up in some bootstrap script for you app, and then just do your job - write you code and write your tests.

I would also recommend watching this [video on designing for testability](http://www.youtube.com/watch?v=acjvKJiOvXw), which will encourage you to leave your singletons and switch to Dagger.

[android development](http://blog.flatstack.com/tagged/android-development), [unit testing](http://blog.flatstack.com/tagged/unit-testing), [dependency injection](http://blog.flatstack.com/tagged/dependency-injection), Untitled [11 December 2013](http://blog.flatstack.com/post/69670609763/android-unit-testing-with-gradle-robolectric-dagger) [Comments](http://blog.flatstack.com/post/69670609763/android-unit-testing-with-gradle-robolectric-dagger#disqus_thread)
