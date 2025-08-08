*Oopsie-trampolines-override
ceContext: aOnceMarriedContext instVar: slotIndex
	"aOnceMarriedContext = 26431360 ifTrue: [self halt]."
	self flag: #todo. "debug why the following fails" "cogit assertCStackWellAligned."
	^super ceContext: aOnceMarriedContext instVar: slotIndex