*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-what to show
toggleAssembler

	self restoreTextualCodingPane.
	self showAssembler: self showingAssembler not.
	self setContentsToForceRefetch.
	self contentsChanged.