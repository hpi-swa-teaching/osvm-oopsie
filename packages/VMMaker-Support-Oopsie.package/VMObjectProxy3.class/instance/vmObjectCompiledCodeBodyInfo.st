as yet unclassified
vmObjectCompiledCodeBodyInfo

	^ self vmObjectDo: [:objectMemory :oop |
		| header bits |
		header := objectMemory baseHeader: oop.
		bits := (header printStringBase: 2 length: 64 padded: true) readStream.
		Text streamContents: [:stream | | commentAttributes indexAttributes |
			commentAttributes := {TextColor color: ((UserInterfaceTheme current get: #comment for: #SHTextStylerST80) first ifNil: [#()]). SHTextStylerST80 enforceItalicEmphasisInComments ifTrue: [TextEmphasis italic] ifFalse: [TextEmphasis normal]}.
			indexAttributes := {TextColor gray}.
			
			stream
				withAttributes: indexAttributes do:
					[stream
						print: 0;
						nextPut: $:];
				tab;
				nextPutAll: (objectMemory fetchPointer: 0 ofObject: oop) hex;
				tab;
				withAttributes: commentAttributes do:
					[stream nextPutAll: self vmObjectGeneratedMethod vmObjectShortPrintString];
				cr.
			
			stream
				withAttributes: commentAttributes do:
					[stream nextPutAll: '"literals"'];
				cr.
			1 to: self numLiterals do: [:index |
				stream
				withAttributes: indexAttributes do:
					[stream
						print: index * 8;
						nextPut: $:];
				tab;
				nextPutAll: (self objectAt: index + 1) vmObjectShortPrintString;
				cr].
			
			stream
				withAttributes: commentAttributes do:
					[stream nextPutAll: '"bytecodes"'];
				cr.
			stream nextPutAll: self symbolicText]]