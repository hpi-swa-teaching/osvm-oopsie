*Oopsie
callInlinePrimitive: index

	| arg1 |
	self push:
		(index caseOf:
			{[2033] -> [arg1 := self pop. self pop < arg1]}).