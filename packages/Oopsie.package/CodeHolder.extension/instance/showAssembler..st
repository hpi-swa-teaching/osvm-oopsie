*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-what to show
showAssembler: aBoolean

	self okToChange ifFalse: [^ self changed: #flash].
	aBoolean
		ifTrue:
			[contentsSymbol := #assembler]
		ifFalse:
			[contentsSymbol = #assembler ifTrue: [contentsSymbol := #source]].
	self setContentsToForceRefetch.
	self contentsChanged.