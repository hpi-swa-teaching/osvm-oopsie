*Oopsie-upstream:VMMaker-instruction decoding
callMappedInlinedPrimitive: primIndex
	self flag: #todo. "remove this and commit typo fix in interpretNext2ByteSistaV1Instruction:for:extA:extB:startPC: instead"
	self drop: (primIndex // 50 max: 0)