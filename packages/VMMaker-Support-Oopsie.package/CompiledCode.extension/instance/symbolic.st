*VMMaker-Support-Oopsie-pseudo-override
symbolic
	"Answer a String that contains a list of all the byte codes in a method 
	with a short description of each."

	| aStream |
	aStream := WriteStream on: (String new: 1000).
	self longPrintOn: aStream.
	self isQuick ifFalse:
		[aStream skip: -1].
	^aStream contents