*Oopsie-fields - streaming
streamVmObjectProxyFieldsOn: aStream

	aStream
		nextPut: self fieldVmMemory;
		nextPut: self fieldVmHeader.
	
	self object streamVmObjectFieldsFor: self on: aStream.