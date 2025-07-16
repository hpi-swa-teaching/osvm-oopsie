as yet unclassified
forObjectMemory: anObjectMemory oop: oop

	| proxy |
	proxy := self basicNew.
	(anObjectMemory isIntegerObject: oop) ifTrue: [^ anObjectMemory integerValueOf: oop].
	(anObjectMemory isImmediateFloat: oop) ifTrue: [^ anObjectMemory floatValueOf: oop].
	anObjectMemory nilObject == oop ifTrue: [^ nil flag: #hacked].
	Pointers at: proxy put: {anObjectMemory. oop}.
	^ proxy