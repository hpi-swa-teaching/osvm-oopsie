*Oopsie-upstream:VMMaker-cog jit support
handleCounterTripped: condition with: counterTrippedSelector
	| classTag context |
	classTag := objectMemory
					classTagForSpecialObjectsIndex: ClassMethodContext
					compactClassIndex: ClassMethodContextCompactIndex.
	(self lookupInMethodCacheSel: counterTrippedSelector classTag: classTag) ifFalse:
	 	[| classObj |
		messageSelector := counterTrippedSelector.
		 classObj := objectMemory classForClassTag: classTag.
		 (self lookupOrdinaryNoMNUEtcInClass: classObj) ~= 0 ifTrue:
			[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
			 ^condition]].
	
	(primitiveFunctionPointer ~= 0
	or: [(self argumentCountOf: newMethod) ~= 1]) ifTrue:
		[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
		 ^condition].
	
	cogit setCogCodeZoneThreshold: 1.0.
	objectMemory splObj: SelectorCounterTripped put: objectMemory nilObject.
	instructionPointer := self popStack.
	context := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self push: context.
	self push: condition.
	self ifAppropriateCompileToNativeCode: newMethod selector: counterTrippedSelector.
	self activateNewMethod.
	"not reached"
	^true