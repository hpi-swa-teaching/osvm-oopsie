printing
print: instruction withArguments: arguments
	| data |
	data := self dataFor: oldPC.
	super print: instruction withArguments: arguments.
	stream skip: -1.
	data ifNotNil:
		[stream withAttributes: self attributesForData do:
			[stream nextPutAll: ' ['.
			self printData: data on: stream.
			stream nextPut: $]]].
	stream cr.