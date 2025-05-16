as yet unclassified
vmObjectMemoryInfo

	^ '{1} ({2})' format:
		{self vmObjectOop hex.
		(self vmObjectDo: [:objectMemory :oop |
			objectMemory interpreter whereIs: oop]) withBlanksTrimmed}