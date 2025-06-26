instruction processing
context: aContext pushReceiverVariable: offset do: aBlock

	| objectMemory interpreter oop |
	(aContext objectClass: aContext receiver) isVmObjectProxyClass ifFalse:
		[^ super context: aContext pushReceiverVariable: offset do: aBlock].
	
	objectMemory := aContext receiver xxxObjectMemory.
	interpreter := objectMemory interpreter.
	oop := aContext receiver xxxOop.
	interpreter push: interpreter instructionPointer.
	^ aContext push:
		(self proxyClass forObjectMemory: objectMemory oop:
			([interpreter ceContext: oop instVar: offset]
				ensure: [interpreter popStack]))