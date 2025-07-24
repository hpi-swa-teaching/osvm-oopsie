*Oopsie-*MethodMassage-Tools-code pane-override-override
pcRangeForByteCode: aContext

	| lineIndex |
	lineIndex := self contents lines findFirst: [:line |
		line notEmpty
			and: [(line attributesAt: 1) anySatisfy: [:attr | attr isCompiledCodeAttribute and: [attr compiledCode ="=" aContext method]]]
			and: [([line withBlanksTrimmed asNumber] ifError: ["metatext (e.g., <primitive>)" nil]) = aContext pc]].
	^ self contents indicesCorrespondingToLine: lineIndex