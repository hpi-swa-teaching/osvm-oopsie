*Oopsie-(-pseudo)-override
printBytes

	| code |
	stream nextPut: $<.
	oldPC to: scanner pc - 1 do: 
		[:i | 
		code := (method at: i) radix: 16.
		stream nextPut: 
			(code size < 2
				ifTrue: [$0]
				ifFalse: [code at: 1]).
		stream nextPut: code last; space].
	stream skip: -1.
	stream nextPut: $>.