style table
stTypeFor: aSymbol

	^ aSymbol
		caseOf:
			{[#symbol] -> [#keyword].
			[#meta] -> [nil]}
		otherwise: [super stTypeFor: aSymbol]