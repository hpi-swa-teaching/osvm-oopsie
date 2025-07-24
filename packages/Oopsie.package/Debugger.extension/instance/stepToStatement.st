*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-context stack menu-override
stepToStatement

	| context |
	context := self showingAnyByteCodes
		ifTrue: [interruptedProcess suspendedContext]
		ifFalse: [interruptedProcess stepToSendOrReturn].
	
	(self contextIsSimulationStepGuard: context) ifTrue:
		[context := (context tempAt: 1) ifNil: [context at: 2].
		 [interruptedProcess suspendedContext == context] whileFalse: [interruptedProcess step].
		 self showByteCodes: true.
		 ^ self stepToStatement].
	
	^ context