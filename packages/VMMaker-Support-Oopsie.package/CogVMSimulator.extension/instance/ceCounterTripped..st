*VMMaker-Support-Oopsie
ceCounterTripped: condition
	| counterTrippedSelector context |
	self transcript cr; nextPutAll: 'counter tripped in '.
	self shortPrintFrame: framePointer.
	(condition = objectMemory falseObject
	or: [condition = objectMemory trueObject]) ifFalse:
		[^self ceSendMustBeBoolean: condition].
	counterTrippedSelector := Smalltalk specialObjectsArray at: SelectorCounterTripped + 1.
	counterTrippedSelector ifNil: [^ condition].
	instructionPointer := self popStack.
	context := self proxyForOop: (self ensureFrameIsMarried: framePointer SP: stackPointer).
	^ objectMemory booleanObjectOf:
		(Context >> counterTrippedSelector valueWithReceiver: context arguments: {objectMemory booleanValueOf: condition})
	