*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-accessing-pseudo-override
newMessageTemplate

	self showingAssembler ifTrue: [^ self newAssemblerMethodTemplate].
	^ (self selectedClassOrMetaClass ifNil: [^ ''])
		ifNil: ['']
		ifNotNil: [:class | class sourceCodeTemplate]