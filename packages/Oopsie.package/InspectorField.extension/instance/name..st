*Oopsie-upstreamCompat:resolveProxy-accessing-override
name: aString

	name = aString ifTrue: [^ self].
	name := aString resolveProxy.
	self changed: #field.