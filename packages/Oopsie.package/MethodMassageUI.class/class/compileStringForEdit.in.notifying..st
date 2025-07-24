accepting
compileStringForEdit: aStringOrText in: aClass notifying: requestor

	| assemblerMethod method selector |
	assemblerMethod := AssemblerMethod fromStringForEdit: aStringOrText notifying: requestor.
	assemblerMethod ifNil: [^ nil].
	
	method := assemblerMethod assemble.
	method propertyValueAt: #assemblerSource put: aStringOrText.
	selector := method selector.
	SystemChangeNotifier uniqueInstance doSilently:
		[method methodClass
			addSelector: selector
			withMethod: method
			notifying: requestor].
	
	^ selector