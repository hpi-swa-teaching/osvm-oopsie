*Oopsie
isExternalObject: oop
	^ (self isCharacterObject: oop) and: [(self isInRangeCharacterCode: (self characterValueOf: oop)) not]