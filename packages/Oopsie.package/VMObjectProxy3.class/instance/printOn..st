printing
printOn: aStream

	self vmObjectDo: [:objectMemory :oop |
		aStream
			nextPutAll: '(vm)';
			nextPutAll: oop storeStringHex;
			nextPutAll: ': '.
		self isContext
			ifTrue: [[self doesNotUnderstand: (Message selector: #printOn: argument: aStream)] ifError: [:error | aStream nextPutAll: '<error: '; nextPutAll: '>']]
			ifFalse: [aStream nextPutAll: (objectMemory interpreter shortPrint: oop)]].