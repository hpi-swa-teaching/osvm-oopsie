*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-context stack menu-override
mainContextStackMenu: aMenu
	"Set up the menu appropriately for the context-stack-list, unshifted"
	<contextStackMenuShifted: false>

	Preferences restartAlsoProceeds
		ifTrue: [
			aMenu
				addTranslatedList: #(	
					('proceed top (p)' 				proceed) 
					('proceed here (r)'				restart))]
		ifFalse: [
			aMenu
				addTranslatedList: #(	
					('proceed (p)' 				proceed) 
					('restart (r)' 				restart))].

	aMenu
		addTranslatedList: #(	
			-
			('step into (e)' 					stepInto) 
			('step over (t)' 					stepOver) 
			('step through (T)'	 			stepIntoBlock)).
	self showingAnyByteCodes ifTrue:
		[aMenu addTranslatedList: #(
			('simulate bytecode step'		simulateStep))].
	aMenu
		addTranslatedList: #(
			-
			('show full stack (f)' 		showFullStack) 
			('show where (w)' 			showWhere)
			-
			('tally it'					tally)
			('peel to first like this' 		peelToFirst)  
			('return entered value' 		returnValue) );
		add: (self isBreakOnEntry ifTrue: ['<on>'] ifFalse: ['<off>']) , 'break on entry' translated
			action: #toggleBreakOnEntry.
	
	self selectedContext ifNotNil:
		[:ctxt|
		ctxt isClosureContext ifTrue:
			[aMenu addTranslatedList: #(('select home'	selectHomeContext))]].
	aMenu
		addTranslatedList: #(
			-
			('senders of    (n)' 			browseSendersOfMessages) 
			('implementors of    (m)' 	browseMessages) 
			('inheritance (i)' 			methodHierarchy) 
			('versions (v)' 				browseVersions) 
			- 
			('references    (r)' 			browseVariableReferences) 
			('assignments    (a)' 		browseVariableAssignments) 
			- 
			('class refs (N)' 				browseClassRefs) 
			('browse full (b)' 			browseMethodFull) 
			('file out ' 			 		fileOutMessage) 
			('remove method (x) ' 		removeMessage) 
			- 
			('copy bug report to clipboard'	copyBugReportToClipboard)).
	^aMenu