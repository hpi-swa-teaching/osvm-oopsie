*Oopsie
fieldVmStringBytes

	^ (self newFieldForType: #vm key: #vmStringBytes)
		name: 'vm bytes'; emphasizeName;
		valueGetter: [:obj | obj vmObjectStringBytes]; printValueAsIs;
		yourself