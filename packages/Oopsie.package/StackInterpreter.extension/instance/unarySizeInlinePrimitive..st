*Oopsie-upstream:VMMaker-sista inline primitives - unary-override
unarySizeInlinePrimitive: primIndex
	<option: #SistaVM>
	| result top |
	self assert: (primIndex between: 1 and: 6).
	top := self internalStackTop.
	primIndex caseOf: {
		"1001	numSlots
		 pointer object => Smi between 0 and SmallInteger maxVal // 4 - 1 (Answers total size in pointer-sized slots)"
		[1]	->	[self assert: (objectMemory isPointers: top).
				 result := objectMemory numSlotsOfAny: top.
				 self assert: (result between: 0 and: objectMemory maxSmallInteger // 4 - 1)].
		"1002	pointer basicSize"
		[2] ->	[self assert: (objectMemory isPointers: top).
				 self error: 'notYetImplemented'].
		"1003	numBytes
		 byte object => Smi between 0 and SmallInteger maxVal - 9 (Includes compiled code)"
		[3]	->	[self assert: (objectMemory isBytes: top).
				 result := objectMemory numBytesOf: top].
		"1004	numShorts
		 short object => Smi between 0 and SmallInteger maxVal - 9"
		[4]	->	[self assert: (objectMemory isShorts: top).
				 result := objectMemory num16BitUnitsOf: top].
		"1005	numWords
		 word object => Smi between 0 and SmallInteger maxVal - 9"
		[5]	->	[self assert: (objectMemory isWords: top).
				 result := objectMemory num32BitUnitsOf: top].
		"1006	numDoubleWords 
		 double word object => Smi between 0 and SmallInteger maxVal - 9"
		[6]	->	[self assert: (objectMemory isLong64s: top).
				 result := objectMemory num64BitUnitsOf: top].
	}.
	self assert: (result between: 0 and: objectMemory maxSmallInteger - 9).
	self internalStackTopPut: (objectMemory integerObjectOf: result)
	