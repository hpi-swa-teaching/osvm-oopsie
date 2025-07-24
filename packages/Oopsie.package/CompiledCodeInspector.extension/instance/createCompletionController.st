*Oopsie-upstream:MethodMassage-*MethodMassageExtras-Tools-Autocompletion
createCompletionController

	self showingAssembler ifFalse: [^ super createCompletionController].
	^ AssemblerECController model: self