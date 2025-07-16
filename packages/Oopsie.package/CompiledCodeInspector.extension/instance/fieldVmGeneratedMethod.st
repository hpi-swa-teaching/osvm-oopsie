*Oopsie-fields
fieldVmGeneratedMethod

	^ (self newFieldForType: #vm key: #vmGeneratedMethod)
		name: 'vm generated method'; emphasizeName;
		valueGetter: [:obj | obj vmObjectGeneratedMethod]; printValueAsIs;
		yourself