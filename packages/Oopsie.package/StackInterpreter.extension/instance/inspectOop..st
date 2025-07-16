*Oopsie-upstream:VMMaker-debug inspection
inspectOop: oop

	self wantsToUseOopsie ifTrue:
		[^ ToolSet inspect: (self proxyForOop: oop)].
	
	^ (CogOopInspector on: self)
		oop: oop;
		open