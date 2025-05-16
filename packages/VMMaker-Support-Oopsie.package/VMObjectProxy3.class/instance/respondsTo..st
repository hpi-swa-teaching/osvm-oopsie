proxy
respondsTo: selector

	^ [self doesNotUnderstand: (Message selector: #respondsTo: argument: selector)]
		on: Error do: [:ex |
			ToolSet debugException: ex.
			false]