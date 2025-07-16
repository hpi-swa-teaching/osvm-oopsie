*Oopsie-external objects-upstream:VMMaker
externalObjectIndices
	^ externalObjectIndices ifNil: [externalObjectIndices := WeakIdentityKeyDictionary new]