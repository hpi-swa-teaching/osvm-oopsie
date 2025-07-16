*Oopsie-override
name: aString

	name = aString ifTrue: [^ self].
	name := aString resolveProxyString.
	self changed: #field.