*Oopsie
assureNotEmpty
	| inputLine |
	position < readLimit ifTrue: [^ self].
	self queue isEmpty ifTrue: [simulator sendInputToStdin].
	inputLine := self queue next asString, (self queue upToBlocking as: String).
	 collection size <= inputLine size ifTrue:
		[collection := collection species new: inputLine size + 1].
	 collection
		replaceFrom: 1 to: inputLine size with: inputLine startingAt: 1;
	 	at: (readLimit := inputLine size + 1) put: Character lf.
	 position := 0.