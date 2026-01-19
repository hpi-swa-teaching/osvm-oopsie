*Oopsie-upstream:VMMaker-debug printing
printHex: anInteger on: aStream

	traceOn ifTrue:
		[| it16 |
		 it16 := anInteger radix: 16.
		 aStream
			next: 8 - it16 size put: Character space;
			nextPutAll: (anInteger storeStringBase: 16)]