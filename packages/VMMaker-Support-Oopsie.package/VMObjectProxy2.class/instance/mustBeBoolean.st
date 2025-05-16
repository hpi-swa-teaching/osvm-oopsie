as yet unclassified
mustBeBoolean
	"Overwritten to preserve original sender context.
	
	This is required to support conditional jumps (ifTrue:/ifFalse:) based on traced booleans, e.g.:
		(ObjectTracer on: false) ifTrue: [1] ifFalse: [2]."

	^ self mustBeBooleanIn: thisContext sender