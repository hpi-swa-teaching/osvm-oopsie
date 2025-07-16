*Oopsie
fieldFormat

	^ (self newFieldForType: #vm key: #vmCompiledCodeBody)
		name: 'format'; emphasizeName;
		valueGetter: [:obj | obj formatComment];
		printValueAsIs;
		yourself