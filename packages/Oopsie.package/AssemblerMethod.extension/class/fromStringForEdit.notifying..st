*Oopsie-upstream:MethodMassage-instance creation
fromStringForEdit: aStringOrText notifying: requestor

	^ Compiler
		evaluate: aStringOrText
		for: self new
		notifying: requestor