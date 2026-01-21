accessing
vmObjectClassFor: classOop
	"Answer the class in the host image that corresponds to classOop. If that exact class is not available, answer nil."

	| className |
	className := self vmObjectMemory interpreter nameOfClass: classOop.
	(#('Behavior' 'Class' 'Metaclass') includes: className) ifTrue:
		[^ Smalltalk at: className asSymbol].
	(className endsWith: ' class') ifTrue:
		[(Smalltalk classNamed: (className allButLast: ' class' size) asSymbol) ifNotNil: [:class | ^ class class].
		^ Class].
	(Smalltalk classNamed: className asSymbol) ifNotNil: [:class | ^ class].
	^ nil