*Oopsie-external objects-upstream:VMMaker-debug printing interpreter support-override
printImmediateObject: oop on: aStream
	<var: 'aStream' type: #'FILE *'>
	self assert: (self isImmediate: oop).
	(self isExternalObject: oop) ifTrue:
		['%P=external %s\n' f: aStream printf: {oop asVoidPointer. (self externalValueOf: oop) printString}].
	(self isIntegerObject: oop) ifTrue:
		['%P=%ld\n' f: aStream printf: {oop asVoidPointer. (self integerValueOf: oop) asInteger}].
	(self isImmediateCharacter: oop) ifTrue:
		['%P=$%ld ($%lc)\n' f: aStream printf: {oop asVoidPointer.
													(self characterValueOf: oop) asLong.
													self cCoerce: (self characterValueOf: oop) to:  #'wint_t'}].
	(self isImmediateFloat: oop) ifTrue:
		['%P=%g\n' f: aStream printf: {oop asVoidPointer. self floatValueOf: oop}]