*Oopsie-upstream:MethodMassage-printing
assemblerStringForEdit
	^String streamContents: [:s | self printAsAssemblerForEditOn: s]