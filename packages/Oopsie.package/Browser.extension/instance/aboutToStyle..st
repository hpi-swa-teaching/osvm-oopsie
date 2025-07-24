*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-code pane-override
aboutToStyle: aStyler
	"This is a notification that aStyler is about to re-style its text.
	Set the classOrMetaClass in aStyler, so that identifiers
	will be resolved correctly.
	Answer true to allow styling to proceed, or false to veto the styling"
	| type |
	
	self showingAssembler ifTrue: [^ self aboutToStyleAssembler: aStyler]. 
	self isModeStyleable ifFalse: [^false].
	type := self editSelection.
	(#(newMessage editMessage editClass newClass newTrait) includes: type) ifFalse:[^false].
	(type = #editClass or: [type = #newClass] or: [type = #newTrait])
		ifTrue: [aStyler parseAMethod: false]
		ifFalse:
			[aStyler classOrMetaClass: self selectedClassOrMetaClass.
			aStyler parseAMethod: true].
	^true