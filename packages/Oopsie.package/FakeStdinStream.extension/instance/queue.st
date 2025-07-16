*Oopsie-upstream:VMMaker-accessing
queue
	^ queue ifNil: [queue := SharedQueue2 new]