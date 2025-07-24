*Oopsie-upstream:MethodMassage-*MethodMassageExtras-Tools-Autocompletion-upstream:Autocompletion-accessing-override
tryCreateModel
	| modelClass |
	(controller model respondsTo: #modelClassForAutocompletion) ifTrue: [controller model modelClassForAutocompletion ifNotNil: [:class | ^ class class: theClass]].
	modelClass ifNil:
		[self receiverClass
			ifNotNil: [^ ECTypedModel class: receiverClass].
		(controller allowOverriding
			and: [theClass notNil])
			ifTrue: [completionIndex = 1
					ifTrue: [^ ECOverrideModel class: theClass]]].
	
	modelClass ifNil:
		[modelClass := ECUntypedModel.		
		(controller model respondsTo: #modelClass) ifTrue: [controller model modelClass ifNotNilDo: [:class | modelClass := class]]].
	^ modelClass
		class: theClass
		temporaries: self temporaries
		additionals: controller additionals
		variables: variables
		selectors: selectors