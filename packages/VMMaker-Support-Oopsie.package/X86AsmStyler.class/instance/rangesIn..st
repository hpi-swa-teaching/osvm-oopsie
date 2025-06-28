private
rangesIn: aText

	| lines lastHeaderIndex header undecoratedBody deltas delta undecoratedBodyRanges ranges |
	self flag: #todo. "* takes a deep breath *
	- add some manual styling to header?
	- exclude footer from assembler syntax highlighting, maybe manually style it as well
	- optimizations?
	- refactoring: triple to class, generally deduplicate/rewrite/beautify
	- see class side
	"
	
	lines := aText lines.
	lastHeaderIndex := (lines findFirst: [:ea | (ea beginsWith: String tab) not] startingAt: 2) - 1.
	header := Text streamContents: [:stream |
		(lines first: lastHeaderIndex)
			do: [:ea | stream nextPutAll: ea]
			separatedBy: [stream cr]].
	
	deltas := OrderedCollection new. "offsets between undecorated body passed to rangesBlock and decorated equivalent"
	delta := 0.
	undecoratedBody := String streamContents: [:stream |
		(lines allButFirst: lastHeaderIndex)
			do: [:ea |
				| bodyLine |
				bodyLine := ea asString.
				(bodyLine prefixMatchesRegex: '[0-9a-f]{8}\: (?=\S)') ifTrue:
					[| newDelta |
					newDelta := 10.
					deltas add: {stream position. delta := delta + newDelta. #_addressAnnotation}.
					bodyLine := bodyLine allButFirst: newDelta].
				(bodyLine matchesRegex: '.* \: ([0-9A-F]{2} )+$') ifTrue:
					[| i |
					i := (bodyLine lastIndexOf: $:) - 1.
					deltas add: {stream position + i. delta := delta + (bodyLine allButFirst: i) size. #_bytesAnnotation}.
					bodyLine := bodyLine first: i].
				stream nextPutAll: bodyLine]
			separatedBy: [stream cr]].
	
	undecoratedBodyRanges := (rangesBlock value: undecoratedBody) collect: [:tuple |
		SHRange start: tuple first end: tuple second type: tuple third].
	deltas := deltas readStream.
	delta := {0. 0. nil}.
	ranges := Array new: undecoratedBodyRanges size + deltas size streamContents: [:stream |
		undecoratedBodyRanges do: [:bodyRange |
			[deltas atEnd not and: [deltas peek first <= bodyRange start]] whileTrue:
				[stream nextPut: (SHRange start: bodyRange start + header size + 1 + delta second end: bodyRange start + header size + 1 + deltas peek second - 1 type: deltas peek third).
				delta := deltas next].
			bodyRange start: bodyRange start + header size + 1 + delta second.
			[deltas atEnd not and: [deltas peek first <= bodyRange end]] whileTrue:
				[stream nextPut: (SHRange start: bodyRange end + header size + 1 + delta second end: bodyRange end + header size + 1 + deltas peek second - 1 type: deltas peek third).
				delta := deltas next].
			bodyRange end: bodyRange end + header size + 1 + delta second.
			stream nextPut: bodyRange]].
	
	self assert: (ranges allSatisfy: [:ea | ea start > 0 and: [ea end <= aText size]]).
	
	^ ranges