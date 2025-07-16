accessing
dataFor: pc
	^ (self sendAndBranchData
		ifNil: [^ nil])
		detect: [:each | each first = pc] ifNone: [nil]