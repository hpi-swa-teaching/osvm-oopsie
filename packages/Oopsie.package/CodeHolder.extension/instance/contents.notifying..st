*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-accessing-override
contents: input notifying: aController 
	"The retrieved information has changed and its source must now be updated. Answer the result of updating the source."

	self changed: #annotation.

	^ self okayToAccept
		ifFalse: [false]
		ifTrue:
			[self showingAssembler ifTrue: [^ self acceptAssembler: input notifying: aController].
			self compileMessage: input asText notifying: aController].