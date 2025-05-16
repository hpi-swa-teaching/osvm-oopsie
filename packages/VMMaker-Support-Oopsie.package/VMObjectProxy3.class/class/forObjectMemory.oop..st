instance creation
forObjectMemory: anObjectMemory oop: oop

	(anObjectMemory isIntegerObject: oop) ifTrue: [^ anObjectMemory integerValueOf: oop].
	(anObjectMemory isImmediateFloat: oop) ifTrue: [^ anObjectMemory floatValueOf: oop].
	anObjectMemory nilObject == oop ifTrue: [^ nil flag: #hacked].
	^ self basicNew xxxObjectMemory: anObjectMemory oop: oop