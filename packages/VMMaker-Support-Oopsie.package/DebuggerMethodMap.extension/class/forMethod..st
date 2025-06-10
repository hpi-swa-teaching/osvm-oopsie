*VMMaker-Support-Oopsie-*SimulationStudio-Sandbox-instance creation-override-override
forMethod: aMethod "<CompiledMethod>"
	"Answer a DebuggerMethodMap suitable for debugging activations of aMethod.
	 Answer an existing instance from the cache if it exists, cacheing a new one if required."
	
	(thisContext isSandboxContext or: [aMethod isProxy "trouble with identities in dictionaries"]) ifTrue:
		["avoid mutex, don't use cache"
		^ self sandboxedForMethod: aMethod].
	^self protected: [ 
		MapCache
			at: aMethod
			ifAbsent: [self
						cacheDebugMap:
							(self
								forMethod: aMethod
								methodNode: aMethod methodNode)
						forMethod: aMethod] ]