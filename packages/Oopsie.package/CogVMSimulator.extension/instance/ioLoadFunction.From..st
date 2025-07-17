*Oopsie-upstream:VMMaker-plugin support-override
ioLoadFunction: functionString From: pluginString
	"Load and return the requested function from a module"
	| firstTime result |
	firstTime := false.
	transcript
		cr;
		show: '(', byteCount printString, ') Looking for ', functionString, ' in ',
				(pluginString isEmpty ifTrue: ['vm'] ifFalse: [pluginString]).
	(breakSelector notNil
	 and: [(pluginString size = breakSelector size
			and: [(self strncmp: pluginString _: breakSelector _: pluginString size) = 0])
		or: [functionString size = breakSelector size
			and: [(self strncmp: functionString _: breakSelector _: functionString size) = 0]]]) ifTrue:
		[self halt: pluginString, '>>', functionString].
	
	result := self basicIoLoadFunction: functionString From: pluginString.
	result = -1 ifTrue:
		[firstTime ifTrue: [transcript cr; show: '... FAILED; no plugin found'].
		^0].
	result = 0 ifTrue:
		[firstTime ifTrue: [transcript cr; show: '... FAILED; no plugin found'].
		^0].
	transcript show: ' ... okay'.
	^ result