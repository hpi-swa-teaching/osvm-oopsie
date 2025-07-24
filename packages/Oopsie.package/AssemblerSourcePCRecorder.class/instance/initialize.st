initialize-release
initialize

	assemblerMethod := AssemblerMethod new.
	lastAbstractPC := 0.
	abstractPCToSourcePCMaps := IdentityDictionary new.