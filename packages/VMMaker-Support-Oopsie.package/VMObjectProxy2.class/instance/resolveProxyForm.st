as yet unclassified
resolveProxyForm

	^ Form
		extent: self extent x @ self extent y
		depth: self depth
		fromArray: (Compiler evaluate: self bits storeString)
		offset: self offset x @ self offset y