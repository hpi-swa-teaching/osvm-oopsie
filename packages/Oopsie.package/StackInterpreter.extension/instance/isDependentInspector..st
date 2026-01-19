*Oopsie-upstream:VMMaker-*VMMakerUI-user interface-override
isDependentInspector: aModel
	<doNotGenerate>
	| object |
	(aModel isInspector ifTrue: [object := aModel object]; or:
		[aModel isObjectExplorer ifTrue: [object := aModel rootObject]; yourself])
			ifFalse: [^false].
	^object == self
		or: [object == objectMemory]
		or: [(thisContext objectClass: object) isVmObjectProxyClass and: [object xxxObjectMemory == objectMemory]]