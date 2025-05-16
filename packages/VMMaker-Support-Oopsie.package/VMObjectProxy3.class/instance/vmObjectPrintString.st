printing
vmObjectPrintString

	^ String streamContents: [:stream |
		self doesNotUnderstand: (Message selector: #printOn: argument: stream)]