read-only objects
context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock

	| objectMemory interpreter oop |
	(aContext objectClass: anObject) isVmObjectProxyClass ifFalse:
		[^ super context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock].
	
	objectMemory := anObject xxxObjectMemory.
	interpreter := objectMemory interpreter.
	oop := anObject xxxOop.
	interpreter storeMaybeContext: oop receiverVariable: index - 1 withValue: (value xxxOopIn: objectMemory).
	self assert: (anObject xxxObjectMemory isKindOf: VMClass).
	^ value