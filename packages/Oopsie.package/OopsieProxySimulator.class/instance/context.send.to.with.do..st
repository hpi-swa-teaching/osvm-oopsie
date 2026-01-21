controlling
context: aContext send: selector to: receiver with: arguments do: aBlock

	(aContext objectClass: receiver) isOopsieProxyClass ifFalse:
		[^ super context: aContext send: selector to: receiver with: arguments do: aBlock].
	
	^ aContext send: selector to: receiver with: arguments lookupIn: receiver vmObjectClass