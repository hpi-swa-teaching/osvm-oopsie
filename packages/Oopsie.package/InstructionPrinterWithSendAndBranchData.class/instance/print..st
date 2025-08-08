*Oopsie-upstreamCompat:InstructionPrinter with style-printing
print: instruction

	| data |
	self flag: #compatibility. "Remove this method once InstructionPrinter with style has been merged!"
	(self class superclass canUnderstand: #print:withArguments:comment:) ifTrue: [^ super print: instruction].
	
	data := self dataFor: oldPC.
	super print: instruction.
	stream skip: -1.
	
	data ifNotNil:
		[stream withAttributes: self attributesForData do:
			[stream nextPutAll: ' ['.
			self printData: data on: stream.
			stream nextPut: $]]].
	
	stream cr.