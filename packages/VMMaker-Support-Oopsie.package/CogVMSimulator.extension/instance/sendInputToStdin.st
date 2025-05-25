*VMMaker-Support-Oopsie
sendInputToStdin
	(self promptExpression: 'Input:') ifNotNil: [:expression | self sendInputToStdin: expression].