printing
printData: data on: aStream
	| discriminator |
	discriminator := data second.
	discriminator ifNil: [^ aStream nextPutAll: 'megamorphic inline cache'].
	discriminator isNumber ifTrue: [ | reached taken |
		reached := discriminator.
		taken := data third.
		reached = 0 ifTrue: [^ aStream nextPutAll: 'not yet reached'].
		^ aStream
			withAttribute: (TextInspectIt on: data) do: [aStream nextPutAll: 'branch taken'];
			space;
			nextPutAll: ('{1}% ({2}/{3})' format: {(taken / reached * 100) rounded. taken. reached})].
	self assert: discriminator isBehavior.
	aStream withAttribute: (TextInspectIt on: data) do:
		[aStream nextPutAll:
			(data size = 3 ifTrue: ['inline cache'] ifFalse: ['polymorphic inline cache'])].
	data allButFirst pairsDo: [:class :compiledMethodOrSelector |
		aStream space.
		aStream
			withAttribute: (TextInspectIt on: class) do:
				[aStream nextPutAll: class name];
			nextPutAll: ' => '.
		compiledMethodOrSelector isSymbol
			ifTrue:
				 [aStream nextPutAll: compiledMethodOrSelector storeString]
			ifFalse:
				[aStream withAttribute: (TextInspectIt on: compiledMethodOrSelector) do:
					[aStream
						nextPutAll: compiledMethodOrSelector methodClass name;
						nextPutAll: '>>';
						nextPutAll: compiledMethodOrSelector selector storeString]].
		aStream nextPutAll: ', '].
	data size > 1 ifTrue: [aStream skip: -2].