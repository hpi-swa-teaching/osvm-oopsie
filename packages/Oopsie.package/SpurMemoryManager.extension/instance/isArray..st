*Oopsie-upstream:VMMaker-object testing-override
isArray: oop
	<api>
	"Answer true if this is an indexable object with pointer elements, e.g., an array"
	^(self isNonImmediate: oop) and: [self isArrayNonImm: oop]