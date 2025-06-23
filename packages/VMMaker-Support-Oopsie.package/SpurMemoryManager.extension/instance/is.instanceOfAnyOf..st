*VMMaker-Support-Oopsie
is: oop instanceOfAnyOf: arrayOop
	<inline: true>
	| classTag |
	self assert: (self isArrayNonImm: arrayOop).
	classTag := self fetchClassTagOf: oop.
	0 to: (self numSlotsOf: arrayOop) asInteger - 1 do:
		[:i |
		 classTag = (self rawClassTagForClass: (self fetchPointer: i ofObject: arrayOop)) ifTrue:
			[^ true]].
	^ false