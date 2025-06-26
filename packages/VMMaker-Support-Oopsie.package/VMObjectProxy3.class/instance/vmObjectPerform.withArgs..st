message handling
vmObjectPerform: aSymbol withArgs: arguments
	"Equivalent to #perform:withArgs: but escapes simulation to improve perfomance. Workaround. Should use partial simulation (https://github.com/LinqLover/SimulationStudio/pull/56) instead."

	^ (self vmObjectClass lookupSelector: aSymbol)
		valueWithReceiver: self arguments: arguments