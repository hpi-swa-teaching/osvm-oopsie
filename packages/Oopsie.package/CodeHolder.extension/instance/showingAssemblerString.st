*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-what to show
showingAssemblerString

	^ (self showingAssembler
		ifTrue:
			['<yes>']
		ifFalse:
			['<no>']), 'assembler'