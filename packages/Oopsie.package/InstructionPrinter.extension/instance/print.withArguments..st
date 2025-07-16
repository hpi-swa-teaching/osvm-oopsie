*Oopsie-(-pseudo)-override
print: instruction withArguments: arguments
	"Append to the receiver a description of the bytecode, instruction." 

	stream tab: self indent.
	printPC ifTrue:
		[stream withAttributes: self attributesForPC do:
			[stream print: oldPC; space]].
	stream tab: (innerIndents at: oldPC).
	stream withAttributes: self attributesForBytes do:
		[self printBytes].
	stream space.
	(stream isKindOf: TextStream)
		ifFalse:
			[stream nextPutAll: (instruction format: arguments)]
		ifTrue:
			[| instructionText |
			instructionText := (Text newFrom: instruction)
				format:
					(arguments collect: [:argument |
						argument isText
							ifTrue: [argument]
							ifFalse:
								[(Text newFrom: argument asStringOrText)
									addAllAttributes: self attributesForInstructionArgument;
									yourself]]).
			instructionText addAllAttributes: self attributesForInstruction unless: [:attrs | attrs notEmpty].
			stream nextPutAll: instructionText].
	stream cr.
	oldPC := scanner pc.
	"(InstructionPrinter compiledMethodAt: #print:) symbolic."