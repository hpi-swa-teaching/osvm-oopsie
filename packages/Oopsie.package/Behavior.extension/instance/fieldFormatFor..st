*Oopsie-upstream:Trunk - tools
fieldFormatFor: inspector
	<inspectorField>

	^ (inspector newFieldForType: #vm key: #vmCompiledCodeBody)
		name: 'format'; emphasizeName;
		valueGetter: [:obj | obj formatComment];
		printValueAsIs;
		yourself