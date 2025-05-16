printing
vmObjectShortPrintString

	^ String streamContents: [:stream |
		stream nextPutAll: (objectMemory interpreter shortPrint: oop)].