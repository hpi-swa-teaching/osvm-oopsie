*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-code pane-override
aboutToStyle: aStyler

	currentCompiledMethod ifNil: [^ false].
	self showingAssembler ifTrue: [^ self aboutToStyleAssembler: aStyler].
	self isModeStyleable ifFalse: [^ false].
	aStyler parseAMethod: true.
	aStyler classOrMetaClass: self selectedClassOrMetaClass.
	^ true