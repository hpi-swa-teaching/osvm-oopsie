proxy
doesNotUnderstand: aMessage

	"When we send this message to ourselves manually inside the simulation."
	(thisContext isSimulatorContext and: [thisContext simulator isKindOf: VMObjectProxySimulator]) ifTrue:
		[^ aMessage sendTo: self].
	
	^ VMObjectProxySimulator evaluate:
		[aMessage sendTo: self]