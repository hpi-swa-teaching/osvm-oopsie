as yet unclassified
fieldDisassembly
	^ (self newFieldForType: #misc key: #disassembly)
		name: 'disassembly' translated; emphasizeName;
		printValueAsIs;
		valueGetter: [:cogMethod | (String streamContents: [:stream | cogMethod disassembleOn: stream]) withBlanksTrimmed];
		yourself