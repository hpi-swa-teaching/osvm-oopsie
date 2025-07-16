*Oopsie-fields
fieldVmBody

	^ (self newFieldForType: #vm key: #vmCompiledCodeBody)
		name: 'vm method body'; emphasizeName;
		valueGetter: [:obj | obj vmObjectCompiledCodeBodyInfo]; printValueAsIs;
		yourself