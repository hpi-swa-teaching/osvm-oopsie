as yet unclassified
vmObjectClass

	^ (self vmObjectDo: [:objectMemory :oop |
		((objectMemory isImmediate: oop) not and: [objectMemory isFreeObject: oop]) ifTrue: [^ UndefinedObject].
		self vmObjectClassFor: (objectMemory fetchClassOf: oop)])
			ifNil: [Object]