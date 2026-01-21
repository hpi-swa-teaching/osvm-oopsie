*Oopsie-proxies
resolveOopsieProxy: proxy

	^ self
		extent: proxy extent x resolveProxy @ proxy extent y resolveProxy
		depth: proxy depth resolveProxy
		fromArray: (Bitmap resolveOopsieProxy: proxy bits)
		offset: proxy offset x resolveProxy @ proxy offset y resolveProxy