fields
fieldMethod
	^ (self newFieldForType: #misc key: #method)
		name: 'method' translated; emphasizeName;
		valueGetter: #methodObjectProxy;
		yourself