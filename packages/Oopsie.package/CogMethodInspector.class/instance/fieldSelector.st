fields
fieldSelector
	^ (self newFieldForType: #misc key: #selector)
		name: 'selector' translated; emphasizeName;
		valueGetter: #selectorProxy;
		yourself