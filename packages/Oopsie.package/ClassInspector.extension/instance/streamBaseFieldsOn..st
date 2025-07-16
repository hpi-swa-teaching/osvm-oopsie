*Oopsie
streamBaseFieldsOn: aStream

	super streamBaseFieldsOn: aStream.
	aStream nextPut: self fieldFormat.