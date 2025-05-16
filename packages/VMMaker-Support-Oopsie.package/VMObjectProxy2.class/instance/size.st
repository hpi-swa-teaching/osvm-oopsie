as yet unclassified
size

	| size |
	size := self doesNotUnderstand: (Message selector: #size).
	self vmObjectClass isCompiledMethodClass ifTrue:
		[^ size + self initialPC].

	^ size