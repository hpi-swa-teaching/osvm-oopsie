initialize-release
registerInCodeHolder

	self unregisterFromCodeHolder.
	CodeHolder
		addContentsSymbolQuint:
			#(assembler toggleAssembler showingAssemblerString 'assembler' 'MethodMassage')
			afterEntry: #byteCodes;
		addEditContentsOption: #assembler -> #selectedAssembler.