tools
streamAllInspectorFieldsFor: anInspector on: aStream
	"Overridden for performance."

	^ [self vmObjectClass someInstance oopsieUnsimulatedPerform: #streamAllInspectorFieldsFor:on: withArgs: {anInspector. aStream}] on: Error do: [:ex |
		ex halt.
		#()]