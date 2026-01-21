*Oopsie-upstream:VMMaker-instruction decoding
callMappedInlinedPrimitive: primIndex
	self flag: #commit. "and rename #callMappedInlinePrimitive:"
	self drop: (primIndex // 50 max: 0)