*VMMaker-Support-Oopsie
respondToSistaTrap
	| shouldHandleInProxy sistaTrapSelector |
	shouldHandleInProxy := true.
	sistaTrapSelector := Smalltalk specialObjectsArray at: SelectorSistaTrap + 1.
	(shouldHandleInProxy not or: [sistaTrapSelector isNil or: [sistaTrapSelector = objectMemory nilObject]]) ifTrue: [^ super respondToSistaTrap].
	self handleTrapInHost: sistaTrapSelector withArgs: {}.