*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-message list
selectedAssembler

	currentCompiledMethod ifNil: [currentCompiledMethod := self selectedContext ifNotNil: [:ctx | ctx home method]].
	^ super selectedAssembler