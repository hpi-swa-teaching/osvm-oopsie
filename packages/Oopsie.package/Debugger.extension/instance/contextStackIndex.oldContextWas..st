*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-private-override
contextStackIndex: anInteger oldContextWas: oldContext 
	"Change the context stack index to anInteger, perhaps in response to user selection."

	| isNewMethod newContext cviClass |
	self saveReceiverInspectorState.
	self saveContextVariablesInspectorState.
	contextStackIndex := anInteger.
	anInteger = 0 ifTrue:
		[currentCompiledMethod := contents := nil.
		 self changed: #contextStackIndex.
		 self decorateButtons.
		 self contentsChanged.
		 contextVariablesInspector
			changeInspectorClassTo: DebuggerProcessInspector;
			object: self interruptedProcess.
		 self restoreContextVariablesInspectorState.
		 receiverInspector
			context: nil;
			inspectObject: self receiver.
		 self restoreReceiverInspectorState.
		 ^self].
	isNewMethod := oldContext isNil
		or: [oldContext home method ~= (currentCompiledMethod := self selectedContext home method)].
	isNewMethod ifTrue:
		[contents := self editContentsWithDefault: [self selectedMessage].
		 self contentsChanged.
		 self pcRange].
	self changed: #contextStackIndex.
	self decorateButtons.
	
	newContext := self selectedContext.
	cviClass := newContext contextVariablesInspectorClass.
	(contextVariablesInspector isKindOf: cviClass) ifFalse:
		[contextVariablesInspector
			object: nil;
			changeInspectorClassTo: cviClass].
	contextVariablesInspector object == newContext
		ifFalse: [contextVariablesInspector object: newContext]
		ifTrue: [contextVariablesInspector update]. "ct: this fixes missing context variable updates when stepping from non-top context"
	self restoreContextVariablesInspectorState.
	receiverInspector context: newContext.
	receiverInspector object == self receiver
		ifFalse: [receiverInspector inspectCarefully: self receiver]
		ifTrue: [receiverInspector update].
	self restoreReceiverInspectorState.
	
	isNewMethod ifFalse:
		[self changed: #contentsSelection]