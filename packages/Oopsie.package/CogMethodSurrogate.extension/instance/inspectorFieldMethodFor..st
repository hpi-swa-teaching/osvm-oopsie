*Oopsie-tools
inspectorFieldMethodFor: anInspector

	^ (anInspector newFieldForType: #misc key: #method)
		name: 'method' translated; emphasizeName;
		valueGetter: #methodObjectProxy;
		yourself