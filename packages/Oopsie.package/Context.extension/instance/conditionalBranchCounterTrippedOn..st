*Oopsie
conditionalBranchCounterTrippedOn: boolean
	"Triggered by the Sista JIT. Here you need to manage the adaptive recompilation. When this method is triggered #conditionalBranchCounterTrippedOn: is removed from the specialObjectsArray"
	
	[ Scorch optimizeContext: self ] ensure: [ 
		self skipBackBeforeJump.
		self method resetCounters.
		"Smalltalk vmParameterAt: 17 put: 0.5." "Move back the tide"
		Smalltalk specialObjectsArray at: 59 put: #conditionalBranchCounterTrippedOn: ].
	^ boolean 