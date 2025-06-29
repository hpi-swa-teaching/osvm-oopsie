style table
stTypeFor: aSymbol

	aSymbol = #default ifTrue: [^ nil].
	^ aSymbol
		caseOf:
			{[#symbol] -> [#keyword].
			[#number] -> [#number].
			[#string] -> [#string].
			[#comment] -> [#comment].
			[#built_in] -> [#self].
			[#meta] -> [nil]}
		otherwise: [self halt]