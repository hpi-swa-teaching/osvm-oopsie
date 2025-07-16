as yet unclassified
vmObjectClass

	self vmObjectDo: [:objectMemory :oop |
		| className |
		(objectMemory isFreeObject: oop) ifTrue: [^ nil].
		className := objectMemory interpreter nameOfClass: (objectMemory fetchClassOf: oop).
		"Transcript showln: className."
		(#('Behavior' 'Class' 'Metaclass') includes: className) ifTrue:
			[^ Smalltalk at: className asSymbol].
		(className endsWith: ' class') ifTrue:
			[^ Class].
		(Smalltalk classNamed: className asSymbol) ifNotNil: [:class | ^ class]].
	^ Object