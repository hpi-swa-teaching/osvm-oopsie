printing
vmObjectShortPrintString

	^ String streamContents: [:stream |
		stream nextPutAll: (self vmObjectMemory interpreter shortPrint: self vmOop)].