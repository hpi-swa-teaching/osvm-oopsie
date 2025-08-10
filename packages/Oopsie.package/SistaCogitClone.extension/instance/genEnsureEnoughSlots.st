*Oopsie-upstream:VMMaker-mapped inline primitive generators-override
genEnsureEnoughSlots
	"50	EnsureEnoughWords
	 literal which is a Smi => ret value is receiver"
	|slots skip|
	<var: #skip type: #'AbstractInstruction *'>
	self assert: (self ssTop type = SSConstant and: [objectMemory isIntegerObject: self ssTop constant]).
	slots := objectMemory integerValueOf: self ssTop constant.
	self ssFlushTo: simStackPtr - 1.
	self ssPop: 1.
	self
		MoveAw: objectMemory freeStartAddress R: TempReg;
		CmpCq: objectMemory getScavengeThreshold - (objectMemory bytesPerOop * slots) R: TempReg.
	skip := self JumpBelow: 0.
	objectRepresentation genSetGCNeeded.
	self CallRT: ceCheckForInterruptTrampoline.
	skip jmpTarget: self Label.
	self annotateBytecode: skip getJmpTarget.
	^0