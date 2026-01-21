*Oopsie-upstream:Trunk-fields - streaming-override
streamBaseFieldsOn: aStream
	"Instead of 'all inst vars' show all byte codes and header summary."
	
	aStream
		nextPut: self fieldSelf.
	self object class isOopsieProxyClass ifTrue:
		[self streamVmObjectProxyFieldsOn: aStream].
	aStream
		nextPut: self fieldSource;
		nextPut: self fieldDecompile;
		nextPut: self fieldByteCodes;
		nextPut: self fieldHeader.