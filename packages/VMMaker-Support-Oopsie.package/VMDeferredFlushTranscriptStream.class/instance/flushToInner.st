flushing
flushToInner
	innerTranscript
		nextPutAll: self contents;
		flush.
	self reset.