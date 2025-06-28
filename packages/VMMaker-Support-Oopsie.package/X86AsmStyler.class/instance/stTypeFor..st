style table
stTypeFor: aSymbol

	aSymbol = #default ifTrue: [^ nil].
	^ aSymbol
		caseOf:
			{[#symbol] -> [#keyword].
			[#number] -> [#number].
			[#comment] -> [#comment].
			[#built_in] -> [#self]}
		otherwise: [self halt]