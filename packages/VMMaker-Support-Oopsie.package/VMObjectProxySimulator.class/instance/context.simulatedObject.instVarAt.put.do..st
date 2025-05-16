read-only objects
context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock

	| objectMemory oop |
	(aContext objectClass: anObject) isVmObjectProxyClass ifFalse:
		[^ super context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock].
	
	objectMemory := anObject xxxObjectMemory.
	oop := anObject xxxOop.
	objectMemory storePointer: index - 1 ofObject: oop withValue: (value xxxOopIn: objectMemory).
	self assert: (anObject xxxObjectMemory isKindOf: VMClass).
	^ value