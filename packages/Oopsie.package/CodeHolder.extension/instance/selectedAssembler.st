*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-message list
selectedAssembler

	| assemblerMethod method |
	method := currentCompiledMethod ifNil:
		[self selectedClassOrMetaClass compiledMethodAt: self selectedMessageName ifAbsent: [^ 'Error: Not Found']].
	(method propertyValueAt: #assemblerSource) ifNotNil: [:source | ^ source].
	assemblerMethod := method disassemble.
	^ assemblerMethod assemblerStringForEdit