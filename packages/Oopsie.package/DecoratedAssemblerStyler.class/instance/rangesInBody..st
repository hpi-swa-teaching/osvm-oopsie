private
rangesInBody: aStringOrText

	(TextStyler for: self assemblerLanguage) ifNotNil: [:stylerClass |
		"nested styling"
		^ Array streamContents: [:stream |
			(stylerClass new styledTextFor: aStringOrText asText)
				runs withStartStopAndValueDo: [:start :stop :attributes |
					attributes ifNotEmpty:
						[stream nextPut:
							(SHRange start: start end: stop type: attributes)]]]].
	^ #()