instruction processing
context: aContext proxy: anObject instVarAt: index

	| objectMemory interpreter oop |
	objectMemory := anObject xxxObjectMemory.
	interpreter := objectMemory interpreter.
	oop := anObject xxxOop.
	interpreter push: interpreter instructionPointer.
	^ (self proxyClass forObjectMemory: objectMemory oop:
		([interpreter ceContext: oop instVar: index - 1]
			ensure: [interpreter popStack]))