proxy
doesNotUnderstand: aMessage

	^ VMObjectProxySimulator evaluate:
		[aMessage sendTo: self]