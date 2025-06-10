instruction processing
context: aContext pushReceiverVariable: offset do: aBlock

	| objectMemory interpreter oop |
	(aContext objectClass: aContext receiver) isVmObjectProxyClass ifFalse:
		[^ super context: aContext pushReceiverVariable: offset do: aBlock].
	
	objectMemory := aContext receiver xxxObjectMemory.
	interpreter := objectMemory interpreter.
	oop := aContext receiver xxxOop.
	^ aContext push:
		(self proxyClass forObjectMemory: objectMemory oop:
			(((objectMemory isContextNonImm: oop)
				and: [interpreter isReadMediatedContextInstVarIndex: offset])
					ifTrue: [interpreter
								"internalizeIPandSP;"
								externalInstVar: offset ofContext: oop]
					ifFalse: [objectMemory fetchPointer: offset ofObject: oop]))