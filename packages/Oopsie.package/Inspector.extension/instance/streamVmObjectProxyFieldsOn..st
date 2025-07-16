*Oopsie
streamVmObjectProxyFieldsOn: aStream

	aStream
		nextPut: self fieldVmMemory;
		nextPut: self fieldVmHeader.
	
	self object isString ifTrue:
		[aStream nextPut: self fieldVmStringBytes].