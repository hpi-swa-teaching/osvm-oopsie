controlling
context: aContext tryNamedPrimitiveIn: aCompiledMethod for: receiver withArgs: arguments do: aBlock

	| literal objectMemory oop address |
	literal := aCompiledMethod literalAt: 1.
	(literal isArray and: [literal first == #Oopsie] and: [literal second == #primitiveObjectMemory]) ifTrue: [
		^ receiver xxxObjectMemory].
	(literal isArray and: [literal first == #Oopsie] and: [literal second == #primitiveOop]) ifTrue: [
		^ receiver xxxOop].
	
	(aContext objectClass: receiver) isVmObjectProxyClass ifFalse:
		[^ super context: aContext tryNamedPrimitiveIn: aCompiledMethod for: receiver withArgs: arguments do: aBlock].
	
	objectMemory := receiver xxxObjectMemory.
	oop := receiver xxxOop.
	
	^ self context: aContext withObjectMemory: objectMemory receiver: receiver arguments: arguments simulatePrimitive: [:interpreter |
		| oldArgumentCount |
		oldArgumentCount := interpreter argumentCount.
		interpreter argumentCount: 0.
		[address := objectMemory ioLoadFunction: literal second From: literal first.
		interpreter callExternalPrimitive: address]
			ensure: [interpreter argumentCount: oldArgumentCount]]