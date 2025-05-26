*VMMaker-Support-Oopsie-pseudo-override
symbolicTextWithSignature

	^ Text new: 1000 streamContents: [:stream |
		stream withAttribute: TextEmphasis bold do:
			[self printSignatureOn: stream].
		stream cr.
		self longPrintOn: stream.
		self isQuick ifFalse:
			[stream skip: -1]]