*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-private-override
bytecodeModeChanged

	self changed: #buildControlButtons.
	(contextVariablesInspector respondsTo: #shouldAlwaysShowStackVariables:) ifTrue:
		[contextVariablesInspector
			shouldAlwaysShowStackVariables: self showingAnyByteCodes;
			update].