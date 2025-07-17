controlling
context: aContext tryNamedPrimitiveIn: aCompiledMethod for: receiver withArgs: arguments do: aBlock

	| literal objectMemory oop address |
	literal := aCompiledMethod literalAt: 1.
	(literal isArray and: [literal first == #Oopsie]) ifTrue:
		[^ self context: aContext tryOopsiePrimitiveIn: aCompiledMethod for: receiver withArgs: arguments].
	
	(aContext objectClass: receiver) isVmObjectProxyClass ifFalse:
		[^ super context: aContext tryNamedPrimitiveIn: aCompiledMethod for: receiver withArgs: arguments do: aBlock].
	
	objectMemory := receiver xxxObjectMemory.
	oop := receiver xxxOop.
	
	^ self context: aContext withObjectMemory: objectMemory receiver: receiver arguments: arguments simulatePrimitive: [:interpreter |
		interpreter argumentCount: 0.
		address := objectMemory interpreter basicIoLoadFunction: literal second From: literal first.
		interpreter callExternalPrimitive: address]