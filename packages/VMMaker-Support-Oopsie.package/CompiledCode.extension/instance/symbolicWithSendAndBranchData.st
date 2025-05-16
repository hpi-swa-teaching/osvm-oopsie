*VMMaker-Support-Oopsie
symbolicWithSendAndBranchData

	^ Text new: 1000 streamContents: [:stream |
		self longPrintWithSendAndBranchDataOn: stream.
		stream skip: -1]