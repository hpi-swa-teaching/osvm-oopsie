*VMMaker-Support-Oopsie
streamBaseFieldsOn: aStream

	aStream
		nextPut: self fieldSelf;
		nextPut: self fieldAllInstVars.
	self object class isVmObjectProxyClass ifTrue:
		[self streamVmObjectProxyFieldsOn: aStream].