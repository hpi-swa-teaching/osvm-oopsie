*Oopsie
symbolicWithSendAndBranchData

	^ Text new: 1000 streamContents: [:stream |
		self longPrintWithSendAndBranchDataOn: stream.
		self isQuick ifFalse:
			[stream skip: -1]]