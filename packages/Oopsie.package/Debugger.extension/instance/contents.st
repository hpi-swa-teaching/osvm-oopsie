*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-accessing-override
contents 
	"Depending on the current selection, different information is retrieved.
	Answer a string description of that information.  This information is the
	method in the currently selected context."

	^contents ifNil:
		[self hasContextSelected ifFalse:
			[^ self emptyContents].
		
		self selectedContext
			ifNotNil:
				[self editContentsWithDefault: [self selectedMessage]]
			ifNil: [String new]] 