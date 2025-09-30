*Oopsie-upstream:MethodMassage-*MethodMassage-Tools
inspectorFieldAssemblerFor: anInspector
	<inspectorFieldWithPriority: 20>

	^ (anInspector newFieldForType: #all key: #assembler)
		name: 'assembler' translated; emphasizeName;
		valueGetter: [:obj | obj disassemble];
		printBlock: [:assemblerMethod | assemblerMethod assemblerStringForEdit];
		shouldStyleValue: true;
		yourself