*VMMaker-Support-Oopsie-override
returnTypeForSend: sendNode in: aTMethod ifNil: typeIfNil
	"Answer the return type for a send.  Unbound sends default to typeIfNil.
	 Methods with types as yet unknown have a type determined either by the
	 kernelReturnTypes or the table below, or, if they are in neither set, then nil.
	 The inferred type should match as closely as possible the C type of
	 generated expessions so that inlining would not change the expression.
	 If there is a method for sel but its return type is as yet unknown it mustn't
	 be defaulted, since on a subsequent pass its type may be computable."
	| sel |
	(sel := sendNode selector) ~~ #firstIndexableField:type: ifTrue:
		[(self anyMethodNamed: sel) ifNotNil:
			[:methodOrNil|
			^methodOrNil returnType
				ifNil: [typeIfNil]
				ifNotNil: [self baseTypeForType: methodOrNil returnType]]].
	^kernelReturnTypes
		at: sel
		ifAbsent:
			[sel
				caseOf: {
				[#integerValueOf:]	->	[#sqInt].
				[#isIntegerObject:]	->	[#int].
				[#negated]			->	[self promoteArithmeticTypes: (sendNode receiver typeFrom: self in: aTMethod) and: #int].
				[#+]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#-]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#*]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#/]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#//]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#\\]					->	[self typeForArithmetic: sendNode in: aTMethod].
				[#rem:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#quo:]					->	[self typeForArithmetic: sendNode in: aTMethod].
				"C99 Sec Bitwise shift operators ... 3 Semantics ...
				 The integer promotions are performed on each of the operands. The type of the result is that of the promoted left operand..."
				[#>>]					->	[sendNode receiver typeFrom: self in: aTMethod].
				[#<<]					->	[(self isSignedIntegralCType: (sendNode receiver typeFrom: self in: aTMethod))
												ifTrue: [#sqInt]
												ifFalse: [#usqInt]].
				[#addressOf:]			->	[(sendNode args first typeFrom: self in: aTMethod)
												ifNil: [#sqInt]
												ifNotNil: [:type| type, (type last isSeparator ifTrue: ['*'] ifFalse: [' *'])]].
				[#addressOf:put:]		->	[(sendNode args first typeFrom: self in: aTMethod)
												ifNil: [#sqInt]
												ifNotNil: [:type| type, (type last isSeparator ifTrue: ['*'] ifFalse: [' *'])]].
				[#at:]					->	[self typeForDereference: sendNode in: aTMethod ifNil: typeIfNil].
				[#bitAnd:]				->	[(sendNode args first isConstant and: [sendNode args first value between: 0 and: 16r7FFFFFFF])
												"prefer #usqInt in the VM and #'unsigned int' in plugins"
												ifTrue: [vmClass ifNotNil: [#usqInt] ifNil: [#'unsigned int']]
												ifFalse: [self typeForArithmetic: sendNode in: aTMethod]].
				[#bitOr:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitXor:]				->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitClear:]			->	[self typeForArithmetic: sendNode in: aTMethod].
				[#bitInvert32]			->	[#'unsigned int'].
				[#bitInvert64]			->	[self promoteArithmeticTypes: (sendNode receiver typeFrom: self in: aTMethod) and: #int].
				[#byteSwap32]		->	[#'unsigned int'].
				[#byteSwap64]		->	[#usqLong].
				[#byteSwapped32IfBigEndian:]	->	[#'unsigned int'].
				[#byteSwapped64IfBigEndian:]	->	[#usqLong].
				[#=]					->	[#int].
				[#~=]					->	[#int].
				[#==]					->	[#int].
				[#~~]					->	[#int].
				[#<]					->	[#int].
				[#<=]					->	[#int].
				[#>]					->	[#int].
				[#>=]					->	[#int].
				[#between:and:]		->	[#int].
				[#anyMask:]			->	[#int].
				[#allMask:]			->	[#int].
				[#noMask:]			->	[#int].
				[#isNil]				->	[#int].
				[#notNil]				->	[#int].
				[#&]					->	[#int].
				[#|]					->	[#int].
				[#not]					->	[#int].
				[#asFloat]				->	[#double].
				[#atan]				->	[#double].
				[#exp]					->	[#double].
				[#log]					->	[#double].
				[#sin]					->	[#double].
				[#sqrt]					->	[#double].
				[#mod:f:]				->	[#double].
				[#asLong]				->	[#long].
				[#asInteger]			->	[#sqInt].
				[#asIntegerPtr]			->	[#'sqIntptr_t'].
				[#asUnsignedInteger]		->	[#usqInt].
				[#asUnsignedIntegerPtr]	->	[#'usqIntptr_t'].
				[#asUnsignedLong]		->	[#'unsigned long'].
				[#asUnsignedLongLong]	->	[#usqLong].
				[#asVoidPointer]			->	[#'void *'].
				[#asCharPointer]			->	[#'char *'].
				[#signedIntFromLong]	->	[#int]. "c.f. generateSignedIntFromLong:on:indent:"
				[#signedIntFromLong64]	->	[#sqInt]. "c.f. generateSignedIntFromLong64:on:indent: N.B. not written to answer sqLong because only used in 64-bit realm"
				[#signedIntToLong]		->	[#usqInt]. "c.f. generateSignedIntToLong:on:indent:"
				[#signedIntToLong64]	->	[#usqInt]. "c.f. generateSignedIntToLong64:on:indent:"
				[#signedIntToShort]		->	[#usqInt]. "c.f. generateSignedIntToShort:on:indent:"
				[#cCoerce:to:]				->	[sendNode args last isConstant ifTrue: [self conventionalTypeForType: sendNode args last value]].
				[#cCoerceSimple:to:]			->	[sendNode args last isConstant ifTrue: [self conventionalTypeForType: sendNode args last value]].
				[#firstIndexableField:type:]	->	[sendNode args last isConstant ifTrue: [self conventionalTypeForType: sendNode args last value]].
				[#sizeof:]				->	[#'usqIntptr_t']. "Technically it's a size_t but it matches on target architectures so far..."
				[#ifTrue:ifFalse:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:ifTrue:]		->	[self typeForConditional: sendNode in: aTMethod].
				[#ifTrue:]				->	[self typeForConditional: sendNode in: aTMethod].
				[#ifFalse:]				->	[self typeForConditional: sendNode in: aTMethod].
				[#and:]				->	[#sqInt].
				[#or:]					->	[#sqInt].
				[#xor:]					->	[#sqInt].
				[#caseOf:]				->	[self typeFor: sendNode args first in: aTMethod].
				[#preDecrement]		->	[self typeFor: sendNode receiver in: aTMethod].
				[#preIncrement]		->	[self typeFor: sendNode receiver in: aTMethod] }
				otherwise: "If there /is/ a method for sel but its return type is as yet unknown it /mustn't/ be defaulted,
							since on a subsequent pass its type may be computable.  Only default unbound selectors."
					[(self anyMethodNamed: sel) ifNotNil: [nil] ifNil: [typeIfNil]]]