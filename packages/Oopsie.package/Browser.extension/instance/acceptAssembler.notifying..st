*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-accessing
acceptAssembler: aStringOrText notifying: requestor

	| currentSelector selector |
	currentSelector := self selectedMessageName.
	^ (super acceptAssembler: aStringOrText notifying: requestor)
		ifTrue:
			[selector := currentCompiledMethod selector.
			selector ~~ currentSelector
				ifTrue:
					["category = ClassOrganizer nullCategory
						ifTrue: [self changed: #classSelectionChanged.
								self changed: #classList.
								self messageCategoryListIndex: 1]."
					self setClassOrganizer.  "In case organization not cached"
					self changed: #messageList.
					self messageListIndex: (self messageList indexOf: selector)]];
		yourself