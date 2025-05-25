as yet unclassified
streamBaseFieldsOn: aStream

	super streamBaseFieldsOn: aStream.
	aStream
		nextPut: self fieldDisassembly;
		nextPut: self fieldSelector;
		nextPut: self fieldMethod.