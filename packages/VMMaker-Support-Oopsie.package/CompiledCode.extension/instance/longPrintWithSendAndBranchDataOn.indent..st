*VMMaker-Support-Oopsie
longPrintWithSendAndBranchDataOn: aStream indent: tabs

	self isQuick ifTrue: 
		[self isReturnSpecial ifTrue:
			[^ aStream tab: tabs; nextPutAll: 'Quick return ' , 
				(#('self' 'true' 'false' 'nil' '-1' '0' '1' '2') at: self primitive - 255)].
		^ aStream nextPutAll: 'Quick return field ' , self returnField printString , ' (0-based)'].

	self primitive = 0 ifFalse: [
		aStream tab: tabs.
		self printPrimitiveOn: aStream.
	].
	(InstructionPrinterWithSendAndBranchData on: self)
		sendAndBranchData: self sendAndBranchData;
		indent: tabs;
		printInstructionsOn: aStream.