as yet unclassified
pullStateInto: proxy

	| pointer objectMemory oop instSize variableSize isCompiledMethod |
	pointer := Pointers at: proxy.
	objectMemory := pointer at: 1.
	oop := pointer at: 2.
	isCompiledMethod := (objectMemory isImmediate: oop) not and: [objectMemory isCompiledMethod: oop].
	
	isCompiledMethod
		ifFalse:
			[instSize := (objectMemory integerValueOf: (objectMemory fetchPointer: 2 ofObject: (objectMemory fetchClassOf: oop))) bitAnd: 16rfff.
			variableSize := (objectMemory slotSizeOf: oop) - instSize]
		ifTrue:
			[variableSize := objectMemory numSlotsOfAny: oop].
	(thisContext objectSize: proxy) = variableSize ifFalse:
		[{proxy} elementsForwardIdentityTo: {self basicNew: variableSize} copyHash: true].
	
	isCompiledMethod
		ifFalse:
			[ | max |self haltIf: instSize > self instSize.
			1 to: (instSize clampHigh: self instSize) do: [:index | 
				thisContext object: proxy instVarAt: index put:
					(self forObjectMemory: objectMemory oop:
						(objectMemory fetchPointer: index - 1 ofObject: oop))].
				
			max := 2000.
			1 to: (variableSize clampHigh: max "debugging!") do: [:index | 
				thisContext object: proxy basicAt: index put:
					(self forObjectMemory: objectMemory oop:
						(objectMemory interpreter stObject: oop at: index))].
			max + 1 to: variableSize do: [:index |
				thisContext object: proxy basicAt: index put: nil]]
		ifTrue:
			[1 to: variableSize do: [:index | 
				thisContext object: proxy basicAt: index put:
					(self forObjectMemory: objectMemory oop:
						(objectMemory fetchPointer: index - 1 ofObject: oop))]].