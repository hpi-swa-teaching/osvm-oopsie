*Oopsie-*MethodMassage-Tools-code pane-override-override
aboutToStyle: aStyler
	"This is a notification that aStyler is about to re-style its text.
	Set the classOrMetaClass in aStyler, so that identifiers
	will be resolved correctly.
	Answer true to allow styling to proceed, or false to veto the styling"
	
	self hasContextSelected ifFalse: [^ false].
	self selectedContext isProxy ifTrue: [^ false].
	self showingAssembler ifTrue: [^ self aboutToStyleAssembler: aStyler]. 
	self isModeStyleable ifFalse: [^false].
	aStyler
		parseAMethod: true;
		classOrMetaClass: self selectedClassOrMetaClass;
		sourceMap: self debuggerMap.
	^true