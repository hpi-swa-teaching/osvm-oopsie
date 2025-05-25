*VMMaker-Support-Oopsie-(-pseudo)-override
attributesForComment

	^ {TextColor color: ((UserInterfaceTheme current get: #comment for: #SHTextStylerST80) first ifNil: [#()]). SHTextStylerST80 enforceItalicEmphasisInComments ifTrue: [TextEmphasis italic] ifFalse: [TextEmphasis normal]}.