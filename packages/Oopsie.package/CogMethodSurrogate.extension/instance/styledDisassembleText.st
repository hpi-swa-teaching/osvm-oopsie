*Oopsie-upstream:VMMaker-disassembly
styledDisassembleText

	| string |
	string := self disassembleString.
	(TextStyler for: #DecoratedAssembler) ifNotNil: [:stylerClass |
		^ stylerClass new styledTextFor: string asText].
	^ string