*Oopsie-upstream:VMMaker-bytecode generators
genBranchOnBehaviorLiteral
	"**	254	(5)	11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior literal kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0 and <= 127)
	**	254	(5)	11111110	kkkkkkkk	jjjjjjjj		branch If Instance Of Behavior/Array Of Behavior literal kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ (Extend B bitAnd: 127) * 256, where Extend B >= 128 and <= 255)"
	| testReg literalIndex literal distance target targetFixUp isNegated |
	<var: #targetFixUp type: #'BytecodeFixup *'>
	testReg := self allocateRegForStackEntryAt: 0.
	self ssTop popToReg: testReg.
	self ssPop: 1.
	literalIndex := byte1 + (extA << 8).
	literal := self getLiteral: literalIndex.
	distance := byte2 + ((extB bitAnd: 127) << 8).
	isNegated := extB >= 0.
	extB := 0.
	target := distance + 3 + bytecodePC.
	targetFixUp := self cCoerceSimple: (self ensureFixupAt: target) to: #'AbstractInstruction *'.
	(objectMemory isArray: literal)
		ifTrue: [isNegated
					ifTrue: [objectRepresentation branchIf: testReg notInstanceOfBehaviors: literal target: targetFixUp]
					ifFalse: [objectRepresentation branchIf: testReg instanceOfBehaviors: literal target: targetFixUp]]
		ifFalse: [isNegated
					ifTrue: [objectRepresentation branchIf: testReg notInstanceOfBehavior: literal target: targetFixUp]
					ifFalse: [objectRepresentation branchIf: testReg instanceOfBehavior: literal target: targetFixUp]].
	^0