as yet unclassified
doesNotUnderstand: aMessage

	(thisContext objectClass: self) pullStateInto: self.
	(self vmObjectClass lookupSelector: aMessage selector) ifNotNil: [:method |
		^ [method valueWithReceiver: self arguments: aMessage arguments]
			ensure: [self class pushStateFrom: self]].
	^ super doesNotUnderstand: aMessage