*VMMaker-Support-Oopsie-(-pseudo)-override
attributesForInstructionArgument

	^ (UserInterfaceTheme current get: #number for: #SHTextStylerST80)
		ifNotNil: [:attributes | attributes collect: [:ea | ea isColor ifTrue: [TextColor color: ea] ifFalse: [ea]]]
		ifNil: [{TextColor color: Color red muchDarker}]