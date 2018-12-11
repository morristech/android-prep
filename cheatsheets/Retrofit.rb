cheatsheet do
	title 'Retrofit'
	docset_file_name 'Retrofit'
	keyword 'retrofit'

	category do
		id 'BASICS'

		entry do
			name 'REQUEST METHOD'
			notes "
			There are five built-in annotations: `GET`, `POST`, `PUT`, `DELETE`, and `HEAD`. 
			The relative URL of the resource is specified in the annotation.
			"
		end

		entry do
			command '@Path / @Query / @QueryMap'
			name 'URL MANIPULATION'
		end

		entry do
			command '@Body'
			name 'REQUEST BODY'
		end

		entry do
			command '@FormUrlEncoded & @Field'
			name 'FORM ENCODED'
		end

		entry do
			command '@Multipart & @Part'
			name 'MULTIPART'
		end

		entry do 
			command '@Headers / @Header'
			name 'HEADER MANIPULATION'
		end
	end

	category do
		id 'ADVANCED'

		entry do
			name 'RequestInterceptor'
			notes <<-EOF
			```
			RequestInterceptor requestInterceptor = new RequestInterceptor() {
			  @Override
			  public void intercept(RequestFacade request) {
			    request.addHeader("User-Agent", "Retrofit-Sample-App");
			  }
			};

			RestAdapter restAdapter = new RestAdapter.Builder()
			  .setEndpoint("https://api.github.com")
			  .setRequestInterceptor(requestInterceptor)
			  .build();
			```
			EOF
		end

		entry do
			name 'SYNCHRONOUS'
		end

		entry do
			name 'ASYNCHRONOUS'
		end

		entry do
			name 'OBSERVABLE'
		end

		entry do
			name 'RESPONSE OBJECT TYPE'
			notes "
			HTTP responses are automatically converted to a specified type using the RestAdapter's converter which defaults to JSON. 

			For access to the raw HTTP response use the `Response` type.
			"
		end
	end

	category do
		id 'CONFIGURATION'
	end
end