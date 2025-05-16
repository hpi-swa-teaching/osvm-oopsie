as yet unclassified
vmObjectMemoryInfo

	^ '{1} ({2})' format:
		{self vmOop hex.
		(self vmObjectMemory interpreter whereIs: self vmOop) withBlanksTrimmed}