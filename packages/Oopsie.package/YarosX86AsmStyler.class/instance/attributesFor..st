style table
attributesFor: aSymbol

	aSymbol = #_addressAnnotation ifTrue: [^ {TextColor gray}].
	aSymbol = #_bytesAnnotation ifTrue: [^ {TextColor gray. TextEmphasis italic}].
	^ super attributesFor: aSymbol