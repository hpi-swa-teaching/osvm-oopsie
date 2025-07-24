initialize-release
registerInCodeHolder

	CodeHolder
		addContentsSymbolQuint:
			#(assembler toggleAssembler showingAssemblerString 'assembler' 'MethodMassage')
			afterEntry: #byteCodes;
		addEditContentsOption: #assembler -> #selectedAssembler.