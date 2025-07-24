*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-accessing
acceptAssembler: aStringOrText notifying: requestor

	| currentSelector assemblerMethod method selector category |
	currentSelector := self selectedMessageName.
	
	contents := nil.
	assemblerMethod := AssemblerMethod fromStringForEdit: aStringOrText notifying: requestor.
	assemblerMethod ifNil: [^ false].
	
	"proxy compliant"
	"assemblerMethod
		methodClass: (self environment classNamed: (assemblerMethod methodClass name asSymbolLike: self selectedClass name));
		compiledMethodClass: (self environment classNamed: (#CompiledMethod asSymbolLike: self selectedClass name));
		selector: (assemblerMethod selector asSymbolLike: self selectedClass name)."
	
	method := assemblerMethod assemble.
	method propertyValueAt: #assemblerSource put: aStringOrText.
	selector := method selector.
	category := currentSelector
		ifNil: [self selectedMessageCategoryName ifNil: [self selectedClassOrMetaClass whichCategoryIncludesSelector: selector]]
		ifNotNil: [(self selectedClassOrMetaClass >> self selectedMessageName) methodReference ifNotNil: [ : ref | ref category]].
	SystemChangeNotifier uniqueInstance doSilently:
		[method methodClass
			addAndClassifySelector: selector
			withMethod: method
			inProtocol: category
			notifying: requestor].
	contents := aStringOrText copy.
	currentCompiledMethod := method.
	
	^ true