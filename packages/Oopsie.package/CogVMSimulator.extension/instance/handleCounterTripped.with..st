*Oopsie-scorching
handleCounterTripped: condition with: counterTrippedSelector
	| simulatedCounterTrippedSelector |
	simulatedCounterTrippedSelector := InitializationOptions at: #sistaSimulatedSelectorCounterTripped ifAbsent: [nil].
	simulatedCounterTrippedSelector ifNil:
		[^ super handleCounterTripped: condition with: counterTrippedSelector].
	instructionPointer := self popStack.
	self handleTrapInHost: simulatedCounterTrippedSelector withArgs: {objectMemory booleanValueOf: condition}.