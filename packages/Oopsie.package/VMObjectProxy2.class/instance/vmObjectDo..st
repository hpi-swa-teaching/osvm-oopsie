as yet unclassified
vmObjectDo: objectMemoryAndOopBlock

	| pointer |
	pointer := Pointers at: self.
	^ objectMemoryAndOopBlock valueWithArguments: pointer