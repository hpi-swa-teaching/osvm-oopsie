*Oopsie
handleTrapInHost: aSymbol withArgs: aCollection
	| context receiver |
	context := self proxyForOop: (self ensureFrameIsMarried: framePointer SP: stackPointer).
	
	"Add a fake context of some method to prevent a divorce of `context` resulting in it simply being peeled.
	We want a proper divorce and a following base frame return to occur"
	receiver := objectMemory nilObject.
	self push: receiver.
	messageSelector := objectMemory maybeSplObj: SelectorMustBeBoolean. "no arguments, always present"
	lkupClassTag := objectMemory fetchClassTagOf: receiver.
	lkupClass := objectMemory classForClassTag: lkupClassTag.
	self lookupMethodInClass: lkupClass.
	self justActivateNewMethod: false.
	
	localReturnValue := objectMemory booleanObjectOf:
		(context vmObjectPerform: aSymbol withArgs: aCollection).
	self
		internalizeIPandSP;
		commonReturn;
		externalizeIPandSP.
	"commonReturn already calls fetchNextBytecode, which reenterInterpreter also does"
	localIP := localIP - 1.
	instructionPointer := instructionPointer - 1.
	self reenterInterpreter.