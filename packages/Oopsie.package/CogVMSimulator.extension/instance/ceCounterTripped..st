*Oopsie
ceCounterTripped: condition
	| counterTrippedSelector shouldHandleInProxy |
	shouldHandleInProxy := true.
	self transcript cr; nextPutAll: 'counter tripped in '.
	self shortPrintFrame: framePointer.
	(condition = objectMemory falseObject
	or: [condition = objectMemory trueObject]) ifFalse:
		[^self ceSendMustBeBoolean: condition].
	counterTrippedSelector := Smalltalk specialObjectsArray at: SelectorCounterTripped + 1.
	(shouldHandleInProxy not or: [counterTrippedSelector isNil or: [counterTrippedSelector = objectMemory nilObject]]) ifTrue: [^ super ceCounterTripped: condition].
	
	self halt.
	instructionPointer := self popStack.
	self handleTrapInHost: counterTrippedSelector withArgs: {objectMemory booleanValueOf: condition}.