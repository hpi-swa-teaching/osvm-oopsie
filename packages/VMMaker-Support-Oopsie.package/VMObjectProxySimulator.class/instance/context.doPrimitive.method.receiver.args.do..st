controlling
context: aContext doPrimitive: primitiveIndex method: aCompiledMethod receiver: receiver args: arguments do: aBlock

	| objectMemory oop |
	self flag: #todo. "why is this above the ProxyClass check?"
	primitiveIndex = 188 ifTrue:
		[| methodArg |
		methodArg := arguments last.
		((aContext objectClass: methodArg) isCompiledMethodClass
			and: [methodArg isQuick])
			ifTrue:
				["prevent direct execution of quick primitive in Context"
				self flag: #todo. "support primitive189 and do not erase checks from Context. also in TDB"
				^ aContext doPrimitive: methodArg primitive method: methodArg receiver: (arguments atLast: 3) args: (arguments atLast: 2)]].
	
	(aContext objectClass: receiver) isVmObjectProxyClass ifFalse:
		[^ super context: aContext doPrimitive: primitiveIndex method: aCompiledMethod receiver: receiver args: arguments do: aBlock].
	
	primitiveIndex = 173 ifTrue: [
		^ aContext push: (self context: aContext proxy: (arguments atLast: 2 ifAbsent: [receiver]) instVarAt: (arguments atLast: 1))].
	
	primitiveIndex = 174 ifTrue: [
		^ aContext push: (aContext simulatedObject: (arguments atLast: 3 ifAbsent: [receiver]) instVarAt: (arguments atLast: 2) put: (arguments last))].
	
	objectMemory := receiver xxxObjectMemory.
	oop := receiver xxxOop.
	
	"Quick return inst vars"
	(primitiveIndex >= 264 and: [primitiveIndex <= 519]) ifTrue:
		[^ aContext push:
			(self proxyClass forObjectMemory: objectMemory oop:
				(objectMemory fetchPointer: primitiveIndex - 264 ofObject: oop))].
	
	(VMPrimitives at: primitiveIndex) ifFalse:
		[^ super context: aContext doPrimitive: primitiveIndex method: aCompiledMethod receiver: receiver args: arguments do: aBlock].
	
	^ self context: aContext method: aCompiledMethod withObjectMemory: objectMemory receiver: receiver arguments: arguments simulatePrimitive: [:interpreter | | sp fp |
		sp := interpreter stackPointer. fp := interpreter framePointer.
		[interpreter
			primitiveFunctionPointer: (interpreter functionPointerFor: primitiveIndex inClass: objectMemory nilObject);
			initPrimCall;
			dispatchFunctionPointer: interpreter primitiveFunctionPointer]
				ensure: [primitiveIndex = 76 ifTrue: [interpreter stackPointer: sp; framePointer: fp]]]