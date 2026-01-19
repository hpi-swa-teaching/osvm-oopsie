read-only objects
context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock

	| objectMemory interpreter oop |
	(aContext objectClass: anObject) isVmObjectProxyClass ifFalse:
		[^ super context: aContext simulatedObject: anObject instVarAt: index put: value do: aBlock].
	
	objectMemory := anObject xxxObjectMemory.
	interpreter := objectMemory interpreter.
	oop := anObject xxxOop.
	interpreter push: interpreter instructionPointer.
	[interpreter oopsie: oop instVar: index - 1 put: (value xxxOopIn: objectMemory)]
			ensure: [interpreter popStack].
	self assert: (anObject xxxObjectMemory isKindOf: VMClass).
	^ value