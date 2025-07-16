accessing
nextPut: aCharacter
	super nextPut: aCharacter.
	self queueFlushToInner.