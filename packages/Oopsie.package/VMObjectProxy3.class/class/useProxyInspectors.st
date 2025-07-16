preferences
useProxyInspectors
	<preference: 'Use Oopsie proxy inspectors to inspect oops' category: 'VMMaker' description: 'Object Oriented PointerS Inspection EngIne' type: #Boolean>

	^ ShouldUseProxyInspectors ifNil: [true]