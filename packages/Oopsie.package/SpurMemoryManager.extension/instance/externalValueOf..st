*Oopsie-external objects-upstream:VMMaker
externalValueOf: oop
	^ self externalObjects at: (self characterValueOf: oop) - self firstExternalObjectIndex