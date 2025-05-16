as yet unclassified
copyFrom: start to: stop

	| newSize |
	newSize := stop - start + 1.
	^(self species vmObjectClass theNonMetaClass new: newSize)
		replaceFrom: 1
		to: newSize
		with: self
		startingAt: start