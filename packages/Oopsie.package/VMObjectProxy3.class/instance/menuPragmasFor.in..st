tools - pluggable menus-private
menuPragmasFor: aMenuSymbolOrCollection in: aClass
	"Overridden for performance."

	^ [self vmObjectClass someInstance oopsieUnsimulatedPerform: #menuPragmasFor:in: withArgs: {aMenuSymbolOrCollection. aClass resolveProxy}] on: Error do: [:ex |
		ex halt.
		#()]