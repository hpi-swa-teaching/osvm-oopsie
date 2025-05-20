private
context: aContext method: aCompiledMethod withObjectMemory: objectMemory receiver: receiver arguments: arguments simulatePrimitive: aBlock

	| result |
	result := "self sandbox evaluate:"
		[| interpreter oldArgumentCount oldStackPointer stackTop |
		interpreter := objectMemory interpreter.
		oldArgumentCount := interpreter argumentCount.
		oldStackPointer := interpreter stackPointer.
		interpreter argumentCount: arguments size.
		interpreter push: receiver xxxOop.
		arguments do: [:ea | interpreter push: (ea xxxOopIn: objectMemory)].
		[aBlock value: interpreter.
		stackTop := interpreter stackTop] ensure:
			[interpreter argumentCount: oldArgumentCount.
			interpreter stackPointer: oldStackPointer].
		{interpreter primFailCode. stackTop}] value.
	
	self assert: (receiver xxxObjectMemory isKindOf: VMClass).
	^ (result at: 1) = 0
		ifTrue:
			[aContext push:
				(self proxyClass forObjectMemory: objectMemory oop:
					(result at: 2))]
		ifFalse:
			[(aContext activateMethod: aCompiledMethod withArgs: arguments receiver: receiver)
				failPrimitiveWith:
					(self proxyClass forObjectMemory: objectMemory oop:
						(result at: 1))]