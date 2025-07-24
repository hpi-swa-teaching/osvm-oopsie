*Oopsie-upstream:MethodMassage-*MethodMassageExtras-Tools-Autocompletion-*Autocompletion-override
createCompletionController

	self showingAssembler ifFalse: [^ super createCompletionController].
	^ AssemblerECBrowserController haltOnce model: self