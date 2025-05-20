instance creation
forObjectMemory: anObjectMemory oop: oop
	
	(anObjectMemory isExternalObject: oop) ifTrue: [^ anObjectMemory externalValueOf: oop].
	"(anObjectMemory isCharacterObject: oop) ifTrue: [^ Character value: (anObjectMemory characterValueOf: oop)]."
	(anObjectMemory isIntegerObject: oop) ifTrue: [^ anObjectMemory integerValueOf: oop].
	(anObjectMemory isImmediateFloat: oop) ifTrue: [^ anObjectMemory floatValueOf: oop].
	anObjectMemory nilObject == oop ifTrue: [^ nil flag: #hacked].
	^ self basicNew xxxObjectMemory: anObjectMemory oop: oop