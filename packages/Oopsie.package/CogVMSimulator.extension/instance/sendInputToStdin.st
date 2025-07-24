*Oopsie-upstream:VMMaker-*VMMakerUI-user interface
sendInputToStdin
	(self initialStdinContents ifNil: [self promptExpression: 'Input:'])
		ifNotNil: [:expression | self sendInputToStdin: expression].