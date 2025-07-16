*Oopsie-fields - streaming
streamVmObjectProxyFieldsOn: aStream

	super streamVmObjectProxyFieldsOn: aStream.
	aStream
		nextPut: self fieldVmGeneratedMethod;
		nextPut: self fieldVmBody.