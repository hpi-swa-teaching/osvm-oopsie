flushing
queueFlushToInner
	flushQueued ifTrue: [^ self].
	Project current addDeferredUIMessage: [self flushToInner. flushQueued := false].
	flushQueued := true.