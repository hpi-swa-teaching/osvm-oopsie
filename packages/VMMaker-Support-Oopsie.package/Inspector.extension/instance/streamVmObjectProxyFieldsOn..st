*VMMaker-Support-Oopsie
streamVmObjectProxyFieldsOn: aStream

	aStream
		nextPut: self fieldVmMemory;
		nextPut: self fieldVmHeader.