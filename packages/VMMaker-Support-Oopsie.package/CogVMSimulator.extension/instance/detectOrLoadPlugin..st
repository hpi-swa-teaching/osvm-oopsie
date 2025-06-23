*VMMaker-Support-Oopsie
detectOrLoadPlugin: pluginString
	^ (self pluginList
		detect: [:each | each key = pluginString]
		ifNone: [self loadNewPlugin: pluginString]) value