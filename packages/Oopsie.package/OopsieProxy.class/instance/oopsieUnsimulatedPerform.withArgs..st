message handling
oopsieUnsimulatedPerform: aSymbol withArgs: arguments
	"Equivalent to #perform:withArgs: but escapes simulation to improve perfomance. Workaround. Should use partial simulation (https://github.com/LinqLover/SimulationStudio/pull/56) instead."
	<primitive: 'primitivePerformWithArgsUnsimulated' module: #Oopsie>

	^ (self vmObjectClass lookupSelector: aSymbol)
		valueWithReceiver: self arguments: arguments