instance creation
onTranscript: aTranscriptStream
	^ (self on: String new)
		innerTranscript: aTranscriptStream;
		yourself