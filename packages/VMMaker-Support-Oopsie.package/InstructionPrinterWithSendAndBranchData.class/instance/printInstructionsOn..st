initialize-release
printInstructionsOn: aStream

	self sendAndBranchData: method sendAndBranchData.
	super printInstructionsOn: aStream.