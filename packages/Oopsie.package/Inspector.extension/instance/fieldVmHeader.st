*Oopsie-fields
fieldVmHeader

	^ (self newFieldForType: #vm key: #vmHeader)
		name: 'vm header'; emphasizeName;
		valueGetter: [:obj | obj vmObjectHeaderInfo]; printValueAsIs;
		yourself