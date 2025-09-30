*Oopsie-upstream:VMMaker-tools
inspectorFieldDisassemblyFor: anInspector
	<inspectorField>

	^ (anInspector newFieldForType: #misc key: #disassembly)
		name: 'disassembly' translated; emphasizeName;
		printValueAsIs;
		valueGetter: [:cogMethod | cogMethod styledDisassembleText];
		yourself