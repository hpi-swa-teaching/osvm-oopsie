*VMMaker-Support-Oopsie
ceCounterTripped: condition
	| counterTrippedSelector context shouldHandleInProxy receiver |
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
	
	"Add a fake context of some method to prevent a divorce of `context` resulting in it simply being peeled.
	We want a proper divorce and a following base frame return to occur"
	receiver := objectMemory nilObject.
	self push: receiver.
	messageSelector := objectMemory maybeSplObj: SelectorMustBeBoolean. "no arguments, always present"
	lkupClassTag := objectMemory fetchClassTagOf: objectMemory nilObject.
	lkupClass := objectMemory classForClassTag: lkupClassTag.
	self lookupMethodInClass: lkupClass.
	self justActivateNewMethod: false.
	
	localReturnValue := objectMemory booleanObjectOf:
		(context vmObjectPerform: counterTrippedSelector with: (objectMemory booleanValueOf: condition)).
	self
		internalizeIPandSP;
		commonReturn;
		externalizeIPandSP;
		reenterInterpreter.