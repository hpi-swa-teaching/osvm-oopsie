*Oopsie-upstream:VMMaker-inline primitive unary generators-override
genUnarySizeInlinePrimitive: primIndex 
	| rcvrReg resultReg |
	self assert: (primIndex between: 1 and: 6).
	rcvrReg := self allocateRegForStackEntryAt: 0 notConflictingWith: 0.
	resultReg := self allocateRegNotConflictingWith: (self registerMaskFor: rcvrReg).
	self ssTop popToReg: rcvrReg.
	self ssPop: 1.
	self ssPushRegister: resultReg.
	primIndex caseOf: {
		"1001	numSlots
		 pointer object => Smi between 0 and SmallInteger maxVal // 4 - 1 (Answers total size in pointer-sized slots)"
		[1]	->	[objectRepresentation
					genGetNumSlotsOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInReg: resultReg].
		"1002	pointer basicSize"
		[2]	->	[^EncounteredUnknownBytecode "not implemented"].
		"1003	numBytes
		 byte object => Smi between 0 and SmallInteger maxVal - 9 (Includes compiled code)"
		[3]	->	[objectRepresentation
					genGetNumBytesOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInReg: resultReg].
		"1004	numShorts
		 short object => Smi between 0 and SmallInteger maxVal - 9"
		[4]	->	[^EncounteredUnknownBytecode "not implemented"].
		"1005	numWords
		 word object => Smi between 0 and SmallInteger maxVal - 9"
		[5]	->	[^EncounteredUnknownBytecode "not implemented"].
		"1006	numDoubleWords 
		 double word object => Smi between 0 and SmallInteger maxVal - 9"
		[6]	->	[^EncounteredUnknownBytecode "not implemented"].
	}..
	^ 0