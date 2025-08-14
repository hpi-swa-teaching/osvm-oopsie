*Oopsie-upstream:VMMaker-cog jit support-override
ceCounterTripped: condition
	| counterTrippedSelector |
	self transcript cr; nextPutAll: 'counter tripped in '.
	self shortPrintFrame: framePointer.
	counterTrippedSelector := objectMemory maybeSplObj: SelectorCounterTripped.
	(counterTrippedSelector isNil
	or: [counterTrippedSelector = objectMemory nilObject]) ifFalse:
		[(InitializationOptions at: #haltOnCounterTripped ifAbsent: [true]) ifTrue:
			[self halt: 'counter tripped']].
	^super ceCounterTripped: condition