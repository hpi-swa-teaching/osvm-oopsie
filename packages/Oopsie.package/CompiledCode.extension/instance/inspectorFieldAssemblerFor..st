*Oopsie-upstream:MethodMassage-*MethodMassage-Tools
inspectorFieldAssemblerFor: anInspector
	<inspectorFieldWithPriority: 20>

	^ (anInspector newFieldForType: #all key: #assembler)
		name: 'assembler' translated; emphasizeName;
		valueGetter: [:obj | obj disassemble assemblerStringForEdit]; printValueAsIs;
		shouldStyleValue: true;
		acceptBlock: [:obj :contents :requestor :inspector |
			((Project uiManager
				chooseOptionFromLabeledValues:
					(OrderedDictionary new
						at: 'Okay, display the new method in this inspector' put: [:new | inspector inspect: new];
						at: 'Okay, display the new method in another inspector' put: [:new | ToolSet inspect: new];
						at: 'Okay, but keep inspecting the old method' put: [];
						at: 'Um, let me reconsider' put: nil;
						yourself)
				title: 'This will recompile the method object.')
					ifNotNil: [:postAcceptAction |
						(MethodMassageUI compileStringForEdit: contents in: obj methodClass notifying: requestor)
							ifNotNil: [:selector | postAcceptAction cull: obj methodClass >> selector];
							yourself])
								notNil];
		yourself