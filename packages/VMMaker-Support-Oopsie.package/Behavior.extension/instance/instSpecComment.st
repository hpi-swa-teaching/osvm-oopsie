*VMMaker-Support-Oopsie
instSpecComment

	^ (thisContext methodClass firstPrecodeCommentFor: #instSpec) lines
		detect: [:ea | ea withBlanksTrimmed beginsWith: self instSpec asString]
		ifFound: [:ea | (ea allButFirst: (ea indexOf: $=) + 1) withBlanksTrimmed]