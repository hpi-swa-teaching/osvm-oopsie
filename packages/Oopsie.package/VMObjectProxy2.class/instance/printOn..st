as yet unclassified
printOn: aStream

	self vmObjectDo: [:objectMemory :oop |
		aStream
			nextPutAll: '(vm)';
			nextPutAll: oop storeStringHex;
			nextPutAll: ': ';
			nextPutAll:
				(objectMemory interpreter shortPrint: oop)].