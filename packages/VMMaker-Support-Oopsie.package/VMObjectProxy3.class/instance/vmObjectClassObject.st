as yet unclassified
vmObjectClassObject

	^ self vmObjectDo: [:objectMemory :oop |
		self class forObjectMemory: objectMemory oop:
			(objectMemory fetchClassOf: oop)]