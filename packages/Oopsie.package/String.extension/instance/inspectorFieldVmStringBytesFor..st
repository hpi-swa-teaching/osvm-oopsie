*Oopsie-tools - inspection
inspectorFieldVmStringBytesFor: anInspector

	^ (anInspector newFieldForType: #vm key: #vmStringBytes)
		name: 'vm bytes'; emphasizeName;
		valueGetter: [:obj | obj vmObjectStringBytesInfo]; printValueAsIs;
		yourself