proxy
doesNotUnderstand: aMessage

	self flag: #todo. "don't allow this protocol during simulation"
	
	(self vmObjectClass lookupSelector: aMessage selector) ifNotNil: [:method |
		^ VMObjectProxySimulator evaluate:
			[method valueWithReceiver: self arguments: aMessage arguments]].
	^ super doesNotUnderstand: aMessage