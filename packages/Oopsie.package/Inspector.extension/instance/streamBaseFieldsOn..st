*Oopsie-upstream:Trunk-fields - streaming-override
streamBaseFieldsOn: aStream

	aStream
		nextPut: self fieldSelf;
		nextPut: self fieldAllInstVars.
	self object class isOopsieProxyClass ifTrue:
		[self streamVmObjectProxyFieldsOn: aStream].