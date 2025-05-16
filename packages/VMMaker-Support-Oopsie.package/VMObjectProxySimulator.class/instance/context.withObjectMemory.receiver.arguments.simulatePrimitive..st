private
context: aContext withObjectMemory: objectMemory receiver: receiver arguments: arguments simulatePrimitive: aBlock

	| result |
	self flag: #duplication.
	result := "self sandbox evaluate:"
		[| interpreter oldStackPointer stackTop |
		interpreter := objectMemory interpreter.
		oldStackPointer := interpreter stackPointer.
		[interpreter push: receiver xxxOop.
		arguments do: [:ea | interpreter push: (ea xxxOopIn: objectMemory)].
		aBlock value: interpreter.
		stackTop := interpreter stackTop]
			ensure: [interpreter stackPointer: oldStackPointer].
		{interpreter primFailCode. stackTop}] value.
	
	self assert: (receiver xxxObjectMemory isKindOf: VMClass).
	^ (result at: 1) = 0
		ifTrue:
			[self proxyClass forObjectMemory: objectMemory oop:
				(result at: 2)]
		ifFalse:
			[Context primitiveFailTokenFor:
				(self proxyClass forObjectMemory: objectMemory oop:
					(result at: 1))]