startup/shutdown
startUp: resuming

	resuming ifTrue:
		[JsProcess ifNotNil: [self stop; start "the 2 seconds delay on every image delay irritates you? make it better!"]].