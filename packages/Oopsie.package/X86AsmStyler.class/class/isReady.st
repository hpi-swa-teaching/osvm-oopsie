testing
isReady

	^ CurrentRangesBlock notNil and: [JsProcess notNil ==> [JsProcess isRunning]]