startup/shutdown
stop

	Yaros ifNotNil: [Yaros stop. Yaros := nil].
	JsProcess ifNotNil: [JsProcess processProxy terminate. JsProcess := nil. CurrentRangesBlock := nil].