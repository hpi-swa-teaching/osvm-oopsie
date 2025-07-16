style table
attributesFor: aSymbol

	| stType |
	aSymbol = #_addressAnnotation ifTrue: [^ {TextColor gray}].
	aSymbol = #_bytesAnnotation ifTrue: [^ {TextColor gray. TextEmphasis italic}].
	stType := (self stTypeFor: aSymbol) ifNil: [^ #()].
	^ SHTextStylerST80 new attributesFor: stType