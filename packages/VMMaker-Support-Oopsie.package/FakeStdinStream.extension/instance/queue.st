*VMMaker-Support-Oopsie
queue
	^ queue ifNil: [queue := SharedQueue2 new]