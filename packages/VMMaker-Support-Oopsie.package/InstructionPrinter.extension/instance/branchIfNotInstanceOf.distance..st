*VMMaker-Support-Oopsie-override
branchIfNotInstanceOf: behaviorOrArrayOfBehavior distance: distance
	"If the object on top of stack has the type -or one of the type- present in the literal
	 (the literal is a behavior or an array of behavior), then pop it. Else jumps by the distance."
	self print: 'branchIfNotInstanceOf: ', behaviorOrArrayOfBehavior printString, ' to: ', (scanner pc + distance) printString.