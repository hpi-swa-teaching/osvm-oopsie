accessing
abstractPCToSourcePCMapFor: aCompiledCode

	^ abstractPCToSourcePCMaps at: aCompiledCode ifAbsent: [nil]