instruction processing
context: aContext pushReceiverVariable: offset do: aBlock

	| objectMemory oop |
	(aContext objectClass: aContext receiver) isVmObjectProxyClass ifFalse:
		[^ super context: aContext pushReceiverVariable: offset do: aBlock].
	
	objectMemory := aContext receiver xxxObjectMemory.
	oop := aContext receiver xxxOop.
	^ aContext push:
		(self proxyClass forObjectMemory: objectMemory oop:
			(objectMemory fetchPointer: offset ofObject: oop))