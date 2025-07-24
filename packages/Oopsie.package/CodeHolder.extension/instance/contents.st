*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-contents-override
contents
	"Answer the source code or documentation for the selected method"

	self showingByteCodes ifTrue:
		[^ self selectedBytecodes].

	self showingDocumentation ifTrue:
		[^ self commentContents].

	^ self editContentsWithDefault:
		[self selectedMessage]