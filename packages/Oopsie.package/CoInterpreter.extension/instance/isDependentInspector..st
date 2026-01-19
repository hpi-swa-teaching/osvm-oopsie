*Oopsie-upstream:VMMaker-*VMMakerUI-user interface-override
isDependentInspector: aModel
	<doNotGenerate>
	| object |
	aModel isVMObjectInspector ifTrue:
		[^aModel isDependentInspectorOf: self].
	(super isDependentInspector: aModel) ifTrue:
		[^true].
	(aModel isInspector ifTrue: [object := aModel object]; or:
		[aModel isObjectExplorer ifTrue: [object := aModel rootObject]; yourself])
			ifFalse: [^false].
	^object == cogit
		or: [object == cogit disassembler
		or: [object == cogit literalsManager
		or: [object == cogit methodZone
		or: [object == cogit objectRepresentation]]]]