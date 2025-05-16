accessing
xxxOopIn: anObjectMemory

	anObjectMemory == objectMemory ifTrue: [^ oop].
	^ super xxxOopIn: anObjectMemory