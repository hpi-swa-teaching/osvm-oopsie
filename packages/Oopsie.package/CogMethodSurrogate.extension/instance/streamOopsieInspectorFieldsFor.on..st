*Oopsie-tools
streamOopsieInspectorFieldsFor: anInspector on: aStream
	<inspectorFieldsWithPriority: -10>

	aStream
		nextPut: (self inspectorFieldSelectorFor: anInspector);
		nextPut: (self inspectorFieldMethodFor: anInspector).