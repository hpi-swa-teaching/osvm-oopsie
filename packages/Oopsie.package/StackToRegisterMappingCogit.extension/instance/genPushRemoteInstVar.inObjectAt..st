*Oopsie-upstream:VMMaker-bytecode generator support-override
genPushRemoteInstVar: index inObjectAt: objectIndex
	<inline: false>
	| objectReg resultReg |
	self assert: needsFrame.
	objectReg := self allocateRegNotConflictingWith: 0.
	self genLoadTemp: objectIndex in: objectReg.
	resultReg := self availableRegOrNoneNotConflictingWith: (self registerMaskFor: objectReg). 
	resultReg = NoReg ifTrue: [resultReg := objectReg].
	objectRepresentation
		genLoadSlot: index
		sourceReg: objectReg
		destReg: resultReg.
	^self ssPushRegister: resultReg