read-only objects
context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock

	| objectMemory interpreter oop |
	(aContext objectClass: anObject) isVmObjectProxyClass ifFalse:
		[^ super context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock].
	
	objectMemory := anObject xxxObjectMemory.
	interpreter := objectMemory interpreter.
	oop := anObject xxxOop.
	((objectMemory isContextNonImm: oop)
		and: [interpreter isReadMediatedContextInstVarIndex: index - 1])
			ifTrue:
				[interpreter
					"internalizeIPandSP;"
					externalInstVar: index - 1 ofContext: oop put: (value xxxOopIn: objectMemory)]
			ifFalse:
				[objectMemory storePointer: index - 1 ofObject: oop withValue: (value xxxOopIn: objectMemory)].
	self assert: (anObject xxxObjectMemory isKindOf: VMClass).
	^ value