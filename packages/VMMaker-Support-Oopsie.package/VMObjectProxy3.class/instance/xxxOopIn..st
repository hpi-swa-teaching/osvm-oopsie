accessing
xxxOopIn: anObjectMemory

	anObjectMemory == objectMemory ifTrue: [^ oop].
	^ self doesNotUnderstand: (Message selector: #xxxOopIn: argument: anObjectMemory)