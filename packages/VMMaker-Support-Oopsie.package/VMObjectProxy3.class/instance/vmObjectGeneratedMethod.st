as yet unclassified
vmObjectGeneratedMethod

	^ self vmObjectDo: [:objectMemory :oop |
		self class forObjectMemory: objectMemory oop:
			(objectMemory fetchPointer: 0 ofObject: oop)]