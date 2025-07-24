*Oopsie-upstream:VMMaker-*VMMakerUI-user interface
initialStdinContents
	| contents key |
	key := #initialStdinContents.
	contents := InitializationOptions at: key ifAbsent: [^ nil].
	contents isString ifTrue: [InitializationOptions removeKey: key. ^ contents].
	contents size <= 1 ifTrue: [InitializationOptions removeKey: key. ^ contents at: 1 ifAbsent: [nil]].
	contents isArray ifTrue: [contents := OrderedCollection withAll: contents. InitializationOptions at: key put: contents].
	^ contents removeFirst