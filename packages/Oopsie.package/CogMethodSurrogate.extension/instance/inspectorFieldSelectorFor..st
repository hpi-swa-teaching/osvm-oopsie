*Oopsie-tools
inspectorFieldSelectorFor: anInspector

	^ (anInspector newFieldForType: #misc key: #selector)
		name: 'selector' translated; emphasizeName;
		valueGetter: #selectorProxy;
		yourself