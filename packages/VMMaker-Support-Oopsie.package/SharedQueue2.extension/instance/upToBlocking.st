*VMMaker-Support-Oopsie
upToBlocking
	^ Array streamContents: [:stream | | next |
		[next := self nextOrNil] whileNotNil: [stream nextPut: next]]