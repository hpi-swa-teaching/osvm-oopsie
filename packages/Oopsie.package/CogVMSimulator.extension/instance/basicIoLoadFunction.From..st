*Oopsie-upstream:VMMaker-plugin support
basicIoLoadFunction: functionString From: pluginString
	| firstTime plugin fnSymbol |
	firstTime := false.
	fnSymbol := functionString asSymbol.
	plugin := pluginList 
				detect: [:any| any key = pluginString asString]
				ifNone:
					[firstTime := true.
					 self loadNewPlugin: pluginString].
	plugin ifNil:
		[^-1].
	plugin := plugin value.
	mappedPluginEntries withIndexDo:
		[:pluginAndName :index|
		((pluginAndName at: 1) == plugin 
		and:[(pluginAndName at: 2) == fnSymbol]) ifTrue:
			[^index]].
	(plugin respondsTo: fnSymbol) ifFalse:
		[^0].
	mappedPluginEntries addLast: { plugin. fnSymbol. [plugin perform: fnSymbol. self]}.
	^mappedPluginEntries size