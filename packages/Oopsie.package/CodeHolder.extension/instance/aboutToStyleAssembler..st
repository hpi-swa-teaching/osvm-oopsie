*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-code pane
aboutToStyleAssembler: aStyler

	currentCompiledMethod ifNil: [(self selectedClassOrMetaClass ifNil: [^ false]) compiledMethodAt: self selectedMessageName ifAbsent: [^ false]].
	aStyler classOrMetaClass: nil.
	aStyler parseAMethod: false.
	^ true