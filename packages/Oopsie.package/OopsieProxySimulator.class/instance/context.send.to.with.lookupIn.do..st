controlling
context: aContext send: selector to: receiver with: arguments lookupIn: lookupClass do: aBlock

	(aContext objectClass: receiver) isOopsieProxyClass ifFalse:
		[^ super context: aContext send: selector to: receiver with: arguments lookupIn: lookupClass do: aBlock].
	
	(aContext lookupSelector: selector inClass: lookupClass) ifNil:
		[^ super
			context: aContext
			send: selector
			to: receiver
			with: arguments
			lookupIn: receiver vmObjectClass
			do: aBlock].
	
	^ super context: aContext send: selector to: receiver with: arguments lookupIn: lookupClass do: aBlock