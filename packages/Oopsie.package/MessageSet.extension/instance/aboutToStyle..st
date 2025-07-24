*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-code pane-override
aboutToStyle: aStyler
	"This is a notification that aStyler is about to re-style its text.
	Set the classOrMetaClass in aStyler, so that identifiers will be resolved correctly.
	Answer true to allow styling to proceed, or false to veto the styling."

	| selectedMessageName showingMethod |
	self showingAssembler ifTrue: [^ self aboutToStyleAssembler: aStyler].
	self isModeStyleable ifFalse: [^ false].
	selectedMessageName := self selectedMessageName.
	aStyler classOrMetaClass: self selectedClassOrMetaClass.
	showingMethod := (#(Comment Definition Hierarchy) includes: selectedMessageName) not.
	aStyler parseAMethod: showingMethod.
	^(#(Comment Hierarchy) includes: selectedMessageName) not