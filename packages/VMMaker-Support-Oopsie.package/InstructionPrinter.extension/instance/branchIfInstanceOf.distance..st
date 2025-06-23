*VMMaker-Support-Oopsie-override
branchIfInstanceOf: behaviorOrArrayOfBehavior distance: distance
	"If the object on top of stack has the type -or one of the types- present in the literal
	 (the literal is a behavior or an array of behavior), then pop it. Else jumps by the distance."
	self print: 'branchIfInstanceOf: ', behaviorOrArrayOfBehavior printString, ' to: ', (scanner pc + distance) printString.