source mapping
abstractSourceMapForMethod: aCompiledCode

	| assemblerSource assemblerSourceMethod recorder |
	assemblerSource := (aCompiledCode propertyValueAt: #assemblerSource) ifNil: ["assemblerMethod"aCompiledCode disassemble assemblerStringForEdit].
	assemblerSourceMethod := Compiler new compiledMethodFor: assemblerSource in: nil to: AssemblerMethod new notifying: nil ifFail: [self error].
	assemblerSourceMethod propertyValueAt: #source put: 'DoIt' asText , String cr , assemblerSource.
	self assert: assemblerSourceMethod referredInstVars isEmpty.
	
	recorder := AssemblerSourcePCRecorder new.
	assemblerSourceMethod valueWithReceiver: recorder arguments: {}.
	^ (recorder abstractPCToSourcePCMap"For: aCompiledCode")
		collect: [:sourcePC |
			| previousSourcePC |
			previousSourcePC := assemblerSourceMethod concretePCForAbstractPC:
				(assemblerSourceMethod abstractPCForConcretePC: sourcePC) - 1.
			(assemblerSourceMethod debuggerMap rangeForPC: previousSourcePC in: assemblerSourceMethod contextIsActiveContext: true) - 'DoIt\' withCRs size]