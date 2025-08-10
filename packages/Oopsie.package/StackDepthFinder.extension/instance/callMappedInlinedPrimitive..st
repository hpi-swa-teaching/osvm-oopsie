*Oopsie-upstream:VMMaker-instruction decoding
callMappedInlinedPrimitive: primIndex
	self flag: #todo. "remove callMappedInlinePrimitive: (no d) when upstreaming"
	self drop: (primIndex // 50 max: 0)