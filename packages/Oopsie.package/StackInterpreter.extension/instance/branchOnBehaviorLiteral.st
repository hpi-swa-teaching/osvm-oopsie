*Oopsie-upstream:VMMaker-stack bytecodes
branchOnBehaviorLiteral
	"**	254	(5)	11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior literal kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0 and <= 127)
	**	254	(5)	11111110	kkkkkkkk	jjjjjjjj		branch If Instance Of Behavior/Array Of Behavior literal kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ (Extend B bitAnd: 127) * 256, where Extend B >= 128 and <= 255)"
	| object literalIndex literal distance target isNegated isInstance |
	object := self internalStackTop.
	literalIndex := self fetchByte + (extA << 8).
	literal := self literal: literalIndex.
	distance := self fetchByte + ((extB bitAnd: 127) << 8).
	target := distance + 3 + localIP.
	isNegated := extB >= 0.
	isInstance := (objectMemory isArray: literal)
					ifTrue: [objectMemory is: object instanceOfAnyOf: literal]
					ifFalse: [objectMemory is: object instanceOf: literal].
	(isInstance xor: isNegated) ifTrue: [self jump: distance].
	self internalPop: 1.
	self fetchNextBytecode.