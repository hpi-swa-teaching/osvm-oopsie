copying
copyFrom: start to: stop
	"Overridden for performance (?)"

	| newSize |
	newSize := stop - start + 1.
	^(self species new: newSize)
		replaceFrom: 1
		to: newSize
		with: self
		startingAt: start