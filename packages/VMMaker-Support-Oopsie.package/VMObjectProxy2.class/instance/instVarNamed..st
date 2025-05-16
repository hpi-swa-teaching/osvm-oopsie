as yet unclassified
instVarNamed: aString
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self instVarAt: (self vmObjectClass
						instVarIndexFor: aString asString
						ifAbsent: [self error: 'no such inst var' translated])