*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-context stack menu-override
simulateStep

	| sender |
	self okToChange ifFalse: [^ self].
	self interruptedProcessIsReady ifFalse: [^ self shouldNotStep].
	self checkContextSelection.
	sender := self interruptedProcess suspendedContext.
	self interruptedProcess
		install: [sender step] asContext;
		runUntil: [:ctxt | ctxt selector = #step and: [ctxt receiver == sender]].
	self interruptedProcess suspendedContext 
		privSender: sender;
		insertSender:
			[| newSender |
			 newSender := thisContext pop.
			 self flag: #simulateStepGuard. "marker!"
			 self flag: #knownBug. "To step forward to the next statement, you MUST press Into to step into and out of #jump, otherwise the process will terminate. Sorry for the inconvenience! See: https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/message/PAFVBIICFMSZWQF4GWRIM7BAWZKMD46F/"
			 newSender jump] asContext.
	self interruptedProcess
		runUntil: [:ctxt | ctxt selector = #interpretNextInstructionFor:in:];
		runUntil: [:ctxt | ctxt selector ~= #method and: [(ctxt selector beginsWith: #interpret) not]].
	self resetContext: self stepToStatement.
	contents := nil. self showingAnyByteCodes ifTrue: [self togglePlainSource].