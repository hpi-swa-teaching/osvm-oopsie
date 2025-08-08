*Oopsie-trampolines-override
ceContext: aOnceMarriedContext instVar: slotIndex value: anOop
	"aOnceMarriedContext = 26431360 ifTrue:
		[transcript cr; cr.
		 self printContext: aOnceMarriedContext.
		 transcript cr.
		 (self isContext: anOop)
			ifTrue: [self printContext: anOop]
			ifFalse: [self printOop: anOop].
		 self halt]."
	self flag: #todo. "debug why the following fails" "cogit assertCStackWellAligned."
	^super ceContext: aOnceMarriedContext instVar: slotIndex value: anOop