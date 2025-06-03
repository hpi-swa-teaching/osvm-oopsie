accessing
nextPutAll: aCollection
	super nextPutAll: aCollection.
	self queueFlushToInner.