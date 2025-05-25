*VMMaker-Support-Oopsie-(-pseudo)-override
attributesForInstruction

	^ (UserInterfaceTheme current get: #keyword for: #SHTextStylerST80)
		ifNotNil: [:attributes | attributes collect: [:ea | ea isColor ifTrue: [TextColor color: ea] ifFalse: [ea]]]
		ifNil: [{TextColor color: Color blue muchDarker}]