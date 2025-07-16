*Oopsie-upstream:VMMaker-override
sqFile: file Read: count Into: byteArrayIndexArg At: startIndex
	"Simulate the read primitive by answering a line of input"
	| n |
	self assureNotEmpty.
	n := count min: readLimit - position.
	simulator
		strncpy: byteArrayIndexArg + startIndex
		_: (collection copyFrom: position + 1 to: position + n)
		_: n.
	position := position + n.
	^n