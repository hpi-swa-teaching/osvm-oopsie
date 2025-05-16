*VMMaker-Support-Oopsie
formatComment

	^ Text streamContents: [:stream |
		stream
			withAttribute: TextEmphasis bold do:
				[stream nextPutAll: (self format printStringBase: 2 length: 5 + 16 padded: true)];
			cr.
		stream
			withAttribute: TextColor gray do:
				[stream print: 0];
			tab;
			nextPutAll: (self instSpec printStringBase: 2 length: 5 padded: true);
			tab;
			nextPutAll: '= instSpec ';
			print: self instSpec;
			space;
			withAttribute: (TextColor color: Color green muchDarker) do:
				[stream nextPutAll: self instSpecComment];
			cr.
		stream
			withAttribute: TextColor gray do:
				[stream print: 5];
			tab;
			nextPutAll: (self instSize printStringBase: 2 length: 16 padded: true);
			tab;
			nextPutAll: '= instSize ';
			print: self instSize]