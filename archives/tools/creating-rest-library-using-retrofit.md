### Creating a REST library using Retrofit & OkHttp

I've been tasked to modernize our application's networking layer. We
have been writing our own network manager to deal with http 302 redirect
and caching responses, but there are many opensource project that
already does these things very well. I've looked into RoboSpice and
Volley as the more popular choices for doing networking in Android. I
found that they're a good candidate as an improved AsyncTask as well as
providing caching. However both framework are closely related to the
Activity context and doesn't work as well when put into a Service such
as ones that I intent to make with a SyncAdapter. We needed a lower
level framework. To figure out what fits our bill, we wrote down some of
our requirements:  
   

1.  It needs to support Https
2.  We want to translate server JSON into client POJO
3.  The framework needs to allow us to edit the header and post body for
    authentication
4.  We want the ability to pass arguments to methods and insert them as
    part of the URL or the query
5.  We want to save bandwidth with Gzip
6.  We want efficient communication with parallel requests
7.  we want Http caching that follows the server's http cache directive
8.  It needs to follow http 302 redirect
9.  It needs to work well with Android

  
 I stumbled across Square's Retrofit and OkHttp. Here's how it fits.  
   

#### 

#### Retrofit

*Supports Https*  
 In Retrofit's home page, their example uses https, so clearly it
supports it.  

    RestAdapter restAdapter = new RestAdapter.Builder()
        .setServer("https://api.github.com") .build();   
   
 *Converts JSON to POJO*  
 Retrofit use GSON by default to convert Http bodies to and from JSON.
  
   
 *Edit request header and body*  
 Retrofit allow header information to be set statically using annotation
or at runtime using a RequestIntercepter.   
   
 *Edit URL and query*  
 Retrofit uses annotated method arguments to replace PATH or query
placeholders. You can also change it at runtime using
RequestIntercepter.   
   
 *Working with Android*  
 The generated implementation GET and POST can be made synchronously
outside of UI thread, or asynchronously callback on the UI thread, or in
background thread via Netflix's RxJava rx.Observable. So it's very
flexible in what threading model we need. We can also put RoboSpice on
top of Retrofit later if we want.   
   

#### 

#### OkHttp

*Supports GZIP*  
  "Transparent GZIP shrinks download sizes."   
   
 *Efficient Networking*  

-   "SPDY support allows all requests to the same host to share a
    socket."
-   "Connection pooling reduces request latency (if SPDY isn’t
    available)."
-   "it will silently recover from common connection problems"

  
*Local Caching*  
OkHttp's HttpResponseCache allows you to set aside a specific amount of
space in cache directory, very similar to Google's HttpResponseCache.   
   
   
First create an OkHttpClient and set 10MB of space in the cache
director for caching   

    OkHttpClient okHttpClient = new OkHttpClient();
    File cacheDir = context.getCacheDir();
    HttpResponseCache cache = new HttpResponseCache(cacheDir, 10 * 1024 * 1024);
    okHttpClient.setResponseCache(cache);

  
Then in order to add some standard PATH and query parameters I create a
RequestInterceptor   

    private class BasicRequestInterceptor implements RequestInterceptor {
      @Override
      public void intercept(RequestFacade requestFacade) {
          requestFacade.addEncodedPathParam("product_name", mProductName);
          requestFacade.addQueryParam("device", android.os.Build.MODEL);
          requestFacade.addQueryParam("firmware", android.os.Build.VERSION.RELEASE);
      }
    }
  
 Then we can build the RestAdapter and set the OkHttpClient as the
networking component and set the request interceptor so that every
request will be modified to include those Path and query.   
 Note that for debugging purpose I've turned on debugging so I can see
the actual request and response in the log.   
 Also note that the http scheme is set as part of the most.   

    new RestAdapter.Builder()
      .setServer("http://" + this.mHost)
      .setRequestInterceptor(requestInterceptor)
      .setClient(httpClient)
      .setLogLevel(RestAdapter.LogLevel.FULL)
      .build();
  
 Then with the RestAdapter, you call create with the Interface that you
want to create. But before we do that, we need to define the Interface.
  
   
 GET   
 Notice that synchronous call throws RetrofitError at runtime, so I've
declared it in the interface explicitly here. The caller should
try/catch the request in case an error occurred.  

    public class Program {
        public String id;
        public String name;
        public String description;
        public long start_time;
        public long duration;
        public String channel_id;
        public List<String> genre_list;
        public long original_air_date;
    }

    @GET("/{product_name}/guide/v3/programs")
    List<Program> getPrograms(
            @Path("product_name") String productName
            @Query("channel_id") String channelId,
            @Query("start-time") long startTime,
            @Query("timeslice") long timeSlice) throws RetrofitError;   

POST   

    public class AuthTokenPostData {
        public String grant_type = "password";
        public String client_id;
        public String username;
        public String password;
    }

    public class AuthTokenResponse {
        public String token_type;
        public String access_token;
        public String scope;
        public Long expires_in;
        public String refresh_token;
    }

    @POST("/{product_name}/oauth2/tokens.json")
    @Headers({
            HTTP.CONN_DIRECTIVE + ":" + HTTP.CONN_CLOSE,
    })
    AuthTokenResponse getAuthtoken(@Body AuthTokenPostData userNamePassword) throws RetrofitError;
  
 So now, we can create POJO data for all the data that our server
returns, create Interface files for all the APIs that the server has
available, annotate the URL, the header, the post body, and the return
type. And then I should have a brand new and robust REST library for my
application!   
 For more information, visit the  

-   [Retrofit project page](http://square.github.io/retrofit/)
-   [OkHttp project page](http://square.github.io/okhttp/)

