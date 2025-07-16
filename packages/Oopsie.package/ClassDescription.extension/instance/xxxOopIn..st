*Oopsie
xxxOopIn: anObjectMemory
	^ (anObjectMemory findClassNamed: self name)
		ifNil: [super xxxOopIn: anObjectMemory]