style table
attributesFor: anArrayOrSymbol

	anArrayOrSymbol isSymbol ifFalse: [^ anArrayOrSymbol "nested styling"].
	^ anArrayOrSymbol
		caseOf:
			{[#default] -> [#()].
			[#_addressAnnotation] -> [{TextColor gray}].
			[#_bytesAnnotation] -> [{TextColor gray. TextEmphasis italic}]}