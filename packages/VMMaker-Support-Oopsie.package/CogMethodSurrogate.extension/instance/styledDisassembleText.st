*VMMaker-Support-Oopsie
styledDisassembleText

	| string |
	string := (String streamContents: [:stream |
		self disassembleOn: stream])
			withBlanksTrimmed.
	X86AsmStyler isReady ifTrue:
		[^ X86AsmStyler new styledTextFor: string asText].
	^ string