assembling
doesNotUnderstand: aMessage

	| result |
	result := aMessage sendTo: assemblerMethod.
	(assemblerMethod basicInstructions count: [:ea | (assemblerMethod isLabel: ea) not]) > lastAbstractPC ifTrue:
		[| context |
		context := thisContext home sender.
		(abstractPCToSourcePCMaps at: context method ifAbsentPut: [Dictionary new])
			at: (lastAbstractPC := lastAbstractPC + 1) put: context pc].
	^ result