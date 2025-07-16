printing
print: instruction withArguments: arguments comment: commentOrNil

	| data |
	self flag: #moveUpstream. "depends on: styled InstructionPrinter"
	
	data := self dataFor: oldPC.
	super print: instruction withArguments: arguments comment: commentOrNil.
	stream skip: -1.
	
	data ifNotNil:
		[stream withAttributes: self attributesForData do:
			[stream nextPutAll: ' ['.
			self printData: data on: stream.
			stream nextPut: $]]].
	
	stream cr.