*Oopsie-fields
fieldVmMemory

	^ (self newFieldForType: #vm key: #vmAddress)
		name: 'vm address'; emphasizeName;
		valueGetter: [:obj | obj vmObjectMemoryInfo]; printValueAsIs;
		yourself