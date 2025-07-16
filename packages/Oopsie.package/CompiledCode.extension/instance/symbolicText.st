*Oopsie-pseudo-override
symbolicText

	^ Text new: 1000 streamContents: [:stream |
		self longPrintOn: stream.
		stream skip: -1]