instruction processing
context: aContext pushReceiverVariable: offset do: aBlock

	(aContext objectClass: aContext receiver) isOopsieProxyClass ifFalse:
		[^ super context: aContext pushReceiverVariable: offset do: aBlock].
	
	^ aContext push: (self context: aContext proxy: aContext receiver instVarAt: offset + 1)