*Oopsie-upstream:MethodMassage-*MethodMassage-Tools
newAssemblerMethod

	^ (thisContext methodClass >> #theNewAssemblerMethod) disassemble
		methodClass: self selectedClassOrMetaClass;
		selector: #messageSelectorAndArgumentNames;
		trailerData: #[0];
		yourself