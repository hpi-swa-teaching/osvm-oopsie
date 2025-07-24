accessing
initializeSelectorsFor: aClass 
	selectors reset.
	AssemblerMethod organization categories select: [:cat | cat matchesRegex: 'assembling(-.+)?'] thenDo: [:cat |
		selectors addAll:
			((aClass selectorsInCategory: cat)
				collect: [:each | AssemblerECSelectorEntry contents: each type: #selector])].
	BytecodeSizer organization categories select: [:cat | cat matchesRegex: 'assembly(-.+)?'] thenDo: [:cat |
		selectors addAll:
			((BytecodeSizer selectorsInCategory: cat)
				collect: [:each | AssemblerECSelectorEntry contents: each type: #selector])].
	self flag: #todo. "remove duplicates, refactor."