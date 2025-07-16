*Oopsie-upstream:VMMaker-*VMMakerUI-user interface
sendInputToStdin
	(self promptExpression: 'Input:') ifNotNil: [:expression | self sendInputToStdin: expression].