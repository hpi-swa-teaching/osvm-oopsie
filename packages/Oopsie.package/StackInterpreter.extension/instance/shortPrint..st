*Oopsie-external objects-upstream:VMMaker-simulation-override
shortPrint: oop
	<doNotGenerate>
	| name classOop key |
	(objectMemory isImmediate: oop) ifTrue:
		[self cCode: [] inSmalltalk:
			[(objectMemory isExternalObject: oop) ifTrue:
				[^'=external ' , ([(objectMemory externalValueOf: oop) printString] ifError: [:msg | msg])]].
		(objectMemory isImmediateCharacter: oop) ifTrue:
			[^(objectMemory characterValueOf: oop) < 256
				ifTrue:
					['=$', (objectMemory characterValueOf: oop) printString,
					' ($', (String with: (Character value: (objectMemory characterValueOf: oop))), ')']
				ifFalse:
					['=$', (objectMemory characterValueOf: oop) printString, '($???)']].
		(objectMemory isIntegerObject: oop) ifTrue:
			[^'=', (objectMemory integerValueOf: oop) printString,
			' (', (objectMemory integerValueOf: oop) hex, ')'].
		(objectMemory isImmediateFloat: oop) ifTrue:
			[^ '=', (objectMemory noFailFloatValueOf: oop) printString, ' (', oop hex, ')'].
		^'= UNKNOWN IMMEDIATE', ' (', (objectMemory integerValueOf: oop) hex, ')'].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^(oop bitAnd: objectMemory allocationUnit - 1) ~= 0
			ifTrue: [' is misaligned']
			ifFalse: [self whereIs: oop]].
	(objectMemory isFreeObject: oop) ifTrue:
		[^' is a free chunk of size ', (objectMemory sizeOfFree: oop) printString,
			(objectMemory hasSpurMemoryManagerAPI
				ifTrue: [' 0th: ', (objectMemory fetchPointer: 0 ofFreeChunk: oop) hex]
				ifFalse: [''])].
	(objectMemory isForwarded: oop) ifTrue:
		[^' is a forwarded object to ', (objectMemory followForwarded: oop) hex,
			' of slot size ', (objectMemory numSlotsOfAny: oop) printString].
	(objectMemory isFloatInstance: oop) ifTrue:
		[^'=', (objectMemory noFailFloatValueOf: oop) printString].
	oop = objectMemory nilObject ifTrue:
		[^'nil'].
	oop = objectMemory falseObject ifTrue:
		[^'false'].
	oop = objectMemory trueObject ifTrue:
		[^'true'].

	classOop := objectMemory fetchClassOfNonImm: oop.
	((objectMemory objCouldBeClassObj: oop)
	 and: [(objectMemory numSlotsOf: classOop) = metaclassNumSlots]) ifTrue:
		[^'class ', (self nameOfClass: oop)].
	name := self nameOfClass: classOop.
	name size = 0 ifTrue: [name := '??'].
	(self is: oop KindOfClass: (self superclassOf: (objectMemory splObj: ClassByteString))) ifTrue:
		[(name endsWith: #Symbol) ifTrue:
			[^'#', (self stringOf: oop)].
		^(self stringOf: oop) printString].
	name = 'Character' ifTrue: "SpurMemoryManager has immediate Characters (see above); ObjectMemory does not"
		[^'=', (Character value: (objectMemory integerValueOf: 
				(objectMemory fetchPointer: 0 ofObject: oop))) printString].

	"Try to spot association-like things; they're all subclasses of LookupKey"
	((objectMemory isPointersNonImm: oop)
	 and: [classOop ~= objectMemory nilObject
	 and: [((objectMemory instanceSizeOf: classOop) between: ValueIndex + 1 and: ValueIndex + 2)
	 and: [(objectMemory addressCouldBeObj: (key := objectMemory fetchPointer: KeyIndex ofObject: oop))
	 and: [(key = objectMemory nilObject and: [objectMemory addressCouldBeClassObj: (objectMemory fetchPointer: ValueIndex ofObject: oop)])
		or: [objectMemory isBytesNonImm: key]]]]]) ifTrue:
		[| classLookupKey |
		 classLookupKey := objectMemory fetchClassOfNonImm: (objectMemory splObj: SchedulerAssociation).
		 [classLookupKey = objectMemory nilObject ifTrue:
			[^(('AEIOU' includes: name first) ifTrue: ['an '] ifFalse: ['a ']), name].
		  (objectMemory instanceSizeOf: classLookupKey) = (KeyIndex + 1)] whileFalse:
			[classLookupKey := self superclassOf: classLookupKey].
		[(objectMemory instanceSizeOf: (self superclassOf: classLookupKey)) = (KeyIndex + 1)] whileTrue:
			[classLookupKey := self superclassOf: classLookupKey].
		 (self includesBehavior: classOop ThatOf: classLookupKey) ifTrue:
			[^(('AEIOU' includes: name first) ifTrue: ['an '] ifFalse: ['a ']), name,
				' ', (self shortPrint: (objectMemory fetchPointer: KeyIndex ofObject: oop)),
				' -> ',
				(objectMemory fetchPointer: ValueIndex ofObject: oop) hex8]].

	^(('AEIOU' includes: name first) ifTrue: ['an '] ifFalse: ['a ']), name