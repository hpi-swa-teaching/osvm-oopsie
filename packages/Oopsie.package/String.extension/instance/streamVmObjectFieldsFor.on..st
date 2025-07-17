*Oopsie-tools - inspection
streamVmObjectFieldsFor: anInspector on: aStream

	super streamVmObjectFieldsFor: anInspector on: aStream.
	
	aStream nextPut: (self inspectorFieldVmStringBytesFor: anInspector).