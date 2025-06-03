flushing
queueFlushToInner
	flushQueued == true ifTrue: [^ self].
	Project current addDeferredUIMessage: [self flushToInner. flushQueued := false].
	flushQueued := true.