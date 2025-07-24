*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-user interface - styling-override
updateStyler: aStyler requestor: anObject
	"Overridden to configure the styler to parse method source code correctly."
	
	| parseAMethod classOrMetaClass |
	self selectedField
		ifNil: [super updateStyler: aStyler requestor: anObject]
		ifNotNil: [:field |
			(anObject knownName = #valuePane and: [field type = #code])
				ifTrue: [parseAMethod := true. classOrMetaClass := self object methodClass]
				ifFalse: [parseAMethod := false. classOrMetaClass := self doItReceiver class].
			(anObject knownName = #valuePane and: [field key = #assembler])
				ifTrue: [parseAMethod := false. classOrMetaClass := nil].
			
			aStyler
				environment: self environment;
				classOrMetaClass: classOrMetaClass;
				context: self doItContext;
				parseAMethod: parseAMethod].
	
