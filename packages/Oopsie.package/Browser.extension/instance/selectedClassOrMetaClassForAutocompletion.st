*Oopsie-upstream:MethodMassage-*MethodMassageExtras-Tools-Autocompletion-*Autocompletion-override
selectedClassOrMetaClassForAutocompletion

	self showingAssembler ifFalse: [^ self selectedClassOrMetaClass].
	^ AssemblerMethod