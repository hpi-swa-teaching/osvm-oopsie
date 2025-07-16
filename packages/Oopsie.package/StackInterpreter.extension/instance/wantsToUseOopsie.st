*Oopsie-upstream:VMMaker-debug inspection
wantsToUseOopsie

	^ (self environment classNamed: #VMObjectProxy3)
		ifNotNil: [:class | class useProxyInspectors]
		ifNil: [false]