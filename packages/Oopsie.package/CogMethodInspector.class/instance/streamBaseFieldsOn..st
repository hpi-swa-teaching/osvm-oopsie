as yet unclassified
streamBaseFieldsOn: aStream

	super streamBaseFieldsOn: aStream.
	aStream
		nextPut: self fieldSelector;
		nextPut: self fieldMethod;
		nextPut: self fieldDisassembly.