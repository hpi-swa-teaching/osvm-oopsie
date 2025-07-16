*Oopsie
externalObjectOf: anObject
	^ self characterObjectOf:
		((self externalObjectIndices
			at: anObject
			ifAbsentPut: [self externalObjects addLast: anObject; size])
				+ self firstExternalObjectIndex)