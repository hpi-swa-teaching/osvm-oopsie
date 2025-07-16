*Oopsie-upstream:VMMaker-accessing - ui
openPinned

	self coInterpreter wantsToUseOopsie
		ifTrue: [^ self coInterpreter inspectOop: self oop].
	^ super openPinned