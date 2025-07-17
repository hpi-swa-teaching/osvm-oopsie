printing
printOn: aStream

	aStream
		nextPutAll: '(vm)';
		nextPutAll: self vmOop storeStringHex;
		nextPutAll: ': '.
	
	self isContext
		ifTrue:
			[[self doesNotUnderstand: (Message selector: #printOn: argument: aStream)]
				ifError: [:error | aStream nextPutAll: '<error: '; nextPutAll: '>']]
		ifFalse: [aStream nextPutAll: (self vmObjectMemory interpreter shortPrint: self vmOop)].