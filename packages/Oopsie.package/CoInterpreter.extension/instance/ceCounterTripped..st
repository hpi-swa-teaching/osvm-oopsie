*Oopsie-upstream:VMMaker-cog jit support-override
ceCounterTripped: condition
	"Two things are going on here.  The main one is catching a counter trip and attempting
	 to send the SelectorCounterTripped selector.  In this case we would like to back-up
	 the pc to the return address of the send that yields the boolean to be tested, so that
	 after potential optimization, computation proceeds by retrying the jump.  But we cannot,
	 since there may be no send, just a pop (as in and: [] and or: [] chains).  In this case we also
	 want to prevent further callbacks until optimization is complete.  So we nil-out the
	 SelectorCounterTripped entry in the specialSelectorArray.

	 The minor case is that there is an unlikely  possibility that the counter tripped but condition
	 is not a boolean, in which case a mustBeBoolean response should occur."
	<api>
	<option: #SistaCogit>
	"Send e.g. thisContext conditionalBranchCounterTrippedOn: boolean."
	| counterTrippedSelector |
	(condition = objectMemory falseObject
	or: [condition = objectMemory trueObject]) ifFalse:
		[^self ceSendMustBeBoolean: condition].

	counterTrippedSelector := objectMemory maybeSplObj: SelectorCounterTripped.
	(counterTrippedSelector isNil
	or: [counterTrippedSelector = objectMemory nilObject]) ifTrue:
		[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
		 ^condition].

	^self handleCounterTripped: condition with: counterTrippedSelector