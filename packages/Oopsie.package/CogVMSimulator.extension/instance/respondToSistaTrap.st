*Oopsie-scorching
respondToSistaTrap
	| simulatedSistaTrapSelector context newSender receiver |
	self halt: 'sista trap'.
	
	simulatedSistaTrapSelector := InitializationOptions at: #sistaSimulatedSelectorTrap ifAbsent: [nil].
	simulatedSistaTrapSelector ifNil:
		[^ super respondToSistaTrap].
	
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
	
	self flag: #workaround. "We change the contract for #trapTripped for simulation purposes so it simply answers the context it wants to jump to rather than doing so by itself. This is easier to handle for the proxy system, but not necessarily the most elegant implementation."
	newSender := (context oopsieUnsimulatedPerform: simulatedSistaTrapSelector) vmOop.
	self halt: #notYetImplemented. "Scorch needs to answer a context proxy for this to work. However, this is currently not yet implemented. See SoDecompiler>>#recordSunkContext:."
	localReturnValue := newSender. "should not be needed"
	self
		internalizeIPandSP;
		instVar: SenderIndex ofContext: context put: newSender;
		commonReturn;
		popStack;
		externalizeIPandSP.
	"commonReturn already calls fetchNextBytecode, which reenterInterpreter also does"
	localIP := localIP - 1.
	instructionPointer := instructionPointer - 1.
	self reenterInterpreter.