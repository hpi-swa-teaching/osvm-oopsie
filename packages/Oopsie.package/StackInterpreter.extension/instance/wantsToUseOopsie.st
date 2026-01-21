*Oopsie-upstream:VMMaker-debug inspection
wantsToUseOopsie

	^ (self environment classNamed: #OopsieProxy)
		ifNotNil: [:class | class useProxyInspectors]
		ifNil: [false]