*Oopsie-override
at: index put: aCharacter
	"Primitive. Store the Character in the field of the receiver indicated by the index.
	 Fail if the index is not an Integer or is out of bounds, or if the argument is not a
	 Character, or the Character's code is outside the 0-255 range, or if the receiver
	 is read-only. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 64 error: ec>
	aCharacter isCharacter ifFalse:
		[^self errorImproperStore].
	index isInteger
		ifTrue:
			[ec == #'no modification' ifTrue:
				[^thisContext modificationForbiddenFor: self at: index putCharacter: aCharacter].
			 aCharacter isOctetCharacter ifFalse: "Convert to WideString"
				[self becomeForward: (WideString from: self).
				^self at: index put: aCharacter].
			 aCharacter isProxy ifTrue:
				[^self at: index put: aCharacter resolveProxyCharacter].
			 self errorSubscriptBounds: index]
		ifFalse: [self errorNonIntegerIndex]