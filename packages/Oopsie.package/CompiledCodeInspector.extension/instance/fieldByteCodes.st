*Oopsie-upstream:Scorching-fields-override
fieldByteCodes

	^ (self newFieldForType: #all key: #byteCodes)
		name: 'all bytecodes' translated; emphasizeName;
		valueGetter: [:obj | obj symbolicTextWithSendAndBranchData]; printValueAsIs;
		yourself