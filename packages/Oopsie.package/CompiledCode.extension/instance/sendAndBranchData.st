*Oopsie
sendAndBranchData
	"If the method is linked to a cogit method, answers the values of the inline caches and conditional counters of the method, else answers an empty array.
	The result will be an Array such as:
	{ 
	{ bytecode pc  . 20000 . 11 } . => counters values of the conditional jump at this bytecode. 
	{ bytecode pc . class . compiledMethod } . => inline cache value
	{ bytecode pc . class1 . compiledMethod1 . class2 . compiledMethod2 . class3 . #doesNotUnderstand: } => pic value
	{ bytecode pc . nil . selector } . => megamorphic inline cache value
	}
	Note:
	unused send sites are omitted.
	doesNotUnderstand: has the entry: class . #doesNotUnderstand: instead of: class . methodFound .
	"
	
	<primitive: 'primitiveSistaMethodPICAndCounterData' module:''>
	^#()
	
	"^ (Smalltalk globals at: #SoSendAndBranchDataCache) staticSendAndBranchData: self"