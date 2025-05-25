as yet unclassified
vmObjectGeneratedMethod

	^ self vmObjectDo: [:objectMemory :oop |
		self flag: #todo. "could a CompiledMethod actually have multiple cog methods?"
		objectMemory interpreter cogit cogMethodSurrogateAt:
			(objectMemory fetchPointer: 0 ofObject: oop)]