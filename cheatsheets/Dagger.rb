cheatsheet do
	title 'Dagger'
	docset_file_name 'Dagger'
	keyword 'dagger'
	source_url 'http://square.github.io/dagger/'

	category do
		id 'BASICS'

		entry do
			command '@Inject'
			name 'DECLARING DEPENDENCIES'
		end

		entry do 
			command '@Provides'
			name 'SATISFYING DEPENDENCIES'
		end

		entry do
			command '@Module'
			name 'HOST OF ALL PROVIDES'
		end

		entry do
			command 'ObjectGraph.create()'
			name 'BUILDING THE GRAPH'
		end
	end

	category do
		id '@Module OPTIONS'

		entry do 
			command 'injects'
			name 'EXPLICIT INJECTION'
		end

		entry do
			command 'staticInjections'
			name 'STATIC INJECTION'
			notes "
				```
				objectGraph.injectStatics();
				```
			"
		end

		entry do
			command 'complete'
			name 'INCOMPLETE MODULE'
		end

		entry do
			command 'library'
			name 'PROVIDE UNUSED TYPES'
		end

		entry do
			command 'includes'
			name 'INCLUDE OTHER MODULES'
		end

		entry do
			command 'override'
			name 'MODULE OVERRIDES'
		end
	end

	category do
		id 'INJECTION VARIATIONS'

		entry do
			command '@Singleton'
			name 'SINGLETON CLASS'
		end

		entry do
			command 'Lazy<T>'
			name 'LAZY INJECTIONS'
		end

		entry do
			command 'Provider<T>'
			name 'PROVIDER INJECTIONS'
		end

		entry do
			command '@Named'
			name 'QUALIFIERS'
		end
	end
end