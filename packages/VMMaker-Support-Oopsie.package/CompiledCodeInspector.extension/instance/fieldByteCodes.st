*VMMaker-Support-Oopsie-fields-override
fieldByteCodes

	^ (self newFieldForType: #all key: #byteCodes)
		name: 'all bytecodes' translated; emphasizeName;
		valueGetter: [:obj | obj symbolicWithSendAndBranchData]; printValueAsIs;
		yourself