*Oopsie
vmObjectGeneratedMethod

	self vmObjectMemory interpreter isCog ifFalse: [^ nil].
	
	self flag: #todo. "answer nil if there is no generated method"
	self flag: #todo. "could a CompiledMethod actually have multiple cog methods?"
	
	^ self vmObjectMemory interpreter cogit cogMethodSurrogateAt:
		(self vmObjectMemory fetchPointer: 0 ofObject: self vmOop)