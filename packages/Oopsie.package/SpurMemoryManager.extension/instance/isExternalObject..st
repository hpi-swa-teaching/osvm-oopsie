*Oopsie-external objects-upstream:VMMaker
isExternalObject: oop
	<doNotGenerate>
	^ (self isCharacterObject: oop) and: [(self isInRangeCharacterCode: (self characterValueOf: oop)) not]