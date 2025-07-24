*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-accessing-override
debuggerMap
	self showingAssembler ifTrue: [^ self selectedContext assemblerEditDebuggerMap].
	^self selectedContext debuggerMap