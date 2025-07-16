as yet unclassified
vmObjectStringBytes
	"just posin'"

	^ self vmObjectDo: [:objectMemory :oop |
		Text streamContents: [:stream | | commentAttributes indexAttributes |
			commentAttributes := {TextColor color: ((UserInterfaceTheme current get: #comment for: #SHTextStylerST80) first ifNil: [#()]). SHTextStylerST80 enforceItalicEmphasisInComments ifTrue: [TextEmphasis italic] ifFalse: [TextEmphasis normal]}.
			indexAttributes := {TextColor gray}.
			stream nextPutAll: self vmObjectHeaderInfo; cr.
			
			stream
				withAttribute: TextEmphasis bold do:
					[stream nextPutAll: '16r'.
					1 to: self size do: [:i |
						stream nextPutAll: ((self basicAt: i) printStringBase: 16 nDigits: 2)]];
				cr.
			1 to: self size do: [:i |
				stream
					withAttributes: indexAttributes do:
						[stream
							print: 64 + (i - 1 * 8);
							nextPut: $:];
					next: 1 put: $ ;
					tab;
					withAttributes: commentAttributes do:
						[stream
							nextPutAll: '(self at: ';
							print: i;
							nextPut: $)];
					next: 2 put: $ ;
					tab;
					nextPutAll: (self basicAt: i) hex;
					tab;
					withAttributes: commentAttributes do:
						[stream
							nextPutAll: '=';
							withAttribute: (TextInspectIt on: (self class newForObjectMemory: objectMemory oop: (objectMemory characterObjectOf: (self basicAt: i)))) do:
								[stream print: (self at: i)];
					cr]]]]