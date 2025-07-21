*Oopsie-external objects-upstream:VMMaker
externalObjectIndices
	<doNotGenerate>
	^ externalObjectIndices ifNil: [externalObjectIndices := WeakIdentityKeyDictionary new]