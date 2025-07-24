initialize-release
forMethod: aCompiledMethod assemblerMethod: anAssemblerMethod
	methodReference := WeakArray with: aCompiledMethod.
	assemblerMethod := anAssemblerMethod.
	self markRecentlyUsed