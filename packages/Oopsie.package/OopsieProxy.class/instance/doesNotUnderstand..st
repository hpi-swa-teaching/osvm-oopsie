proxy
doesNotUnderstand: aMessage

	"When we send this message to ourselves manually inside the simulation."
	(thisContext isSimulatorContext and: [thisContext simulator isKindOf: OopsieProxySimulator]) ifTrue:
		[^ aMessage sendTo: self].
	
	^ OopsieProxySimulator evaluate:
		[aMessage sendTo: self]