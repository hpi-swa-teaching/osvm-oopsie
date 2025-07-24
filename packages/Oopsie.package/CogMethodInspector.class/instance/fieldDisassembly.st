fields
fieldDisassembly
	^ (self newFieldForType: #misc key: #disassembly)
		name: 'disassembly' translated; emphasizeName;
		printValueAsIs;
		valueGetter: [:cogMethod | cogMethod styledDisassembleText];
		yourself