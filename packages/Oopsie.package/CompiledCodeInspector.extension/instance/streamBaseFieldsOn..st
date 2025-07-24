*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-*Oopsie-upstream:Trunk-fields - streaming-override-override
streamBaseFieldsOn: aStream
	"Instead of 'all inst vars' show all byte codes and header summary."
	
	aStream
		nextPut: self fieldSelf.
	self object class isVmObjectProxyClass ifTrue:
		[self streamVmObjectProxyFieldsOn: aStream].
	aStream
		nextPut: self fieldSource;
		nextPut: self fieldDecompile;
		nextPut: self fieldByteCodes;
		nextPut: self fieldHeader.
	aStream
		nextPut: (self object inspectorFieldAssemblerFor: self).