*Oopsie-upstream:VMMaker-disassembly
disassembleString

	^ (String streamContents: [:stream |
		self disassembleOn: stream])
			withBlanksTrimmed