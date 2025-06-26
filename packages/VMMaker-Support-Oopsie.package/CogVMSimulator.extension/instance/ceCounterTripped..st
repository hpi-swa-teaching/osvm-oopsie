*VMMaker-Support-Oopsie
ceCounterTripped: condition
	| counterTrippedSelector context shouldHandleInProxy |
	shouldHandleInProxy := true.
	self transcript cr; nextPutAll: 'counter tripped in '.
	self shortPrintFrame: framePointer.
	(condition = objectMemory falseObject
	or: [condition = objectMemory trueObject]) ifFalse:
		[^self ceSendMustBeBoolean: condition].
	counterTrippedSelector := Smalltalk specialObjectsArray at: SelectorCounterTripped + 1.
	(shouldHandleInProxy not or: [counterTrippedSelector isNil or: [counterTrippedSelector = objectMemory nilObject]]) ifTrue: [^ super ceCounterTripped: condition].
	
	self halt.
	context :=
		[instructionPointer := self popStack.
		self proxyForOop: (self ensureFrameIsMarried: framePointer SP: stackPointer)]
			ensure: [self push: instructionPointer].
	^ objectMemory booleanObjectOf:
		(context vmObjectPerform: counterTrippedSelector with: (objectMemory booleanValueOf: condition))