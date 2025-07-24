*Oopsie-upstream:MethodMassage-*MethodMassageExtras-Tools-Autocompletion-upstream:Autocompletion-*Autocompletion
guessTypeForName: aString 
	| index object |
	index := (self debuggerMap tempNamesForContext: self selectedContext)
				indexOf: aString
				ifAbsent: [].
	object := index
				ifNil: [index := self receiver class allInstVarNames
								indexOf: aString
								ifAbsent: [].
						index ifNil: [^ nil].
					self receiver instVarAt: index]
				ifNotNil: [self selectedContext tempAt: index].
	^ object class
