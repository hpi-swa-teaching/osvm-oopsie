*Oopsie-override
printOopShortInner: oop
	| classOop name nameLen |
	<var: #name type: #'char *'>
	<inline: false>
	(objectMemory isExternalObject: oop) ifTrue:
		[^'external %s' f: transcript printf: { (objectMemory externalValueOf: oop) printString }].
	(objectMemory isImmediate: oop) ifTrue:
		[(objectMemory isImmediateCharacter: oop) ifTrue:
			[^'$%c(%lx)' f: transcript printf: { self cCoerceSimple: (objectMemory characterValueOf: oop) to: #int.
												objectMemory characterValueOf: oop }].
		 (objectMemory isIntegerObject: oop) ifTrue:
			[^'%ld(16r%lx)' f: transcript printf: { objectMemory integerValueOf: oop. objectMemory integerValueOf: oop }].
		 (objectMemory isImmediateFloat: oop) ifTrue:
			[^'%g(16r%lx)' f: transcript printf: {objectMemory noFailFloatValueOf: oop. oop}].
		 ^'unknown immediate %P' f: transcript printf: oop asVoidPointer].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^self print: ((oop bitAnd: objectMemory allocationUnit - 1) ~= 0
						ifTrue: [' is misaligned']
						ifFalse: [self whereIs: oop])].
	(objectMemory isFreeObject: oop) ifTrue:
		[^self print: ' is a free chunk'].
	(objectMemory isForwarded: oop) ifTrue:
		[| target |
		 target := objectMemory followForwarded: oop.
		 ^' is a forwarder to %P' f: transcript printf: target asVoidPointer].
	(objectMemory isFloatInstance: oop) ifTrue:
		[^self printFloat: (objectMemory noFailFloatValueOf: oop)].
	classOop := objectMemory fetchClassOfNonImm: oop.
	(objectMemory addressCouldBeObj: classOop) ifFalse:
		[^self print: 'a ??'].
	(objectMemory numSlotsOf: classOop) = metaclassNumSlots ifTrue:
		[^self printNameOfClass: oop count: 5].
	oop = objectMemory nilObject ifTrue: [^self print: 'nil'].
	oop = objectMemory trueObject ifTrue: [^self print: 'true'].
	oop = objectMemory falseObject ifTrue: [^self print: 'false'].
	nameLen := self lengthOfNameOfClass: classOop.
	nameLen = 0 ifTrue: [^self print: 'a ??'].
	name := self nameOfClass: classOop.
	((objectMemory isBytes: oop) and: [nameLen >= 6]) ifTrue:
		[(self strncmp: (self cCode: [name + nameLen - 6] inSmalltalk: [name last: 6]) _: 'String' _: 6) = 0 "strncmp is weird" ifTrue:
			[^self printChar: $'; printStringOf: oop; printChar: $'].
		 (self strncmp: (self cCode: [name + nameLen - 6] inSmalltalk: [name last: 6]) _: 'Symbol' _: 6) = 0 "strncmp is weird" ifTrue:
			[self printChar: $#; printStringOf: oop. ^self]].
	(nameLen = 9 and: [(self strncmp: name _: 'Character' _: 9) = 0]) ifTrue:
		[^self printChar: $$; printChar: (objectMemory integerValueOf: (objectMemory fetchPointer: 0 ofObject: oop))].
	'a(n) %.*s' f: transcript printf: { nameLen. name }.
	"Try to spot association-like things; they're all subclasses of LookupKey"
	((objectMemory isPointersNonImm: oop)
	 and: [(objectMemory instanceSizeOf: classOop) = (ValueIndex + 1)
	 and: [(objectMemory isBytes: (objectMemory fetchPointer: KeyIndex ofObject: oop))]]) ifTrue:
		[| classLookupKey |
		 classLookupKey := objectMemory fetchClassOfNonImm: (objectMemory splObj: SchedulerAssociation).
		 [classLookupKey = objectMemory nilObject ifTrue:
			[^self].
		  (objectMemory instanceSizeOf: classLookupKey) = (KeyIndex + 1)] whileFalse:
			[classLookupKey := self superclassOf: classLookupKey].
		 (self includesBehavior: classOop ThatOf: classLookupKey) ifTrue:
			[self space;
				printOopShortInner: (objectMemory fetchPointer: KeyIndex ofObject: oop);
				print: ' -> ';
				printHexnp: (objectMemory fetchPointer: ValueIndex ofObject: oop)]]