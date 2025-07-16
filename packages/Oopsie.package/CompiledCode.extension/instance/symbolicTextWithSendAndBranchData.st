*Oopsie-upstream:Scorching-printing
symbolicTextWithSendAndBranchData

	self flag: #moveUpstream. "depends on: styled InstructionPrinter"
	
	^ Text new: 1000 streamContents: [:stream |
		self longPrintWithSendAndBranchDataOn: stream.
		stream peekLast isSeparator "self isQuick not" ifTrue:
			[stream skip: -1]]