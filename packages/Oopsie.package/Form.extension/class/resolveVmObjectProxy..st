*Oopsie-proxies
resolveVmObjectProxy: proxy

	^ self
		extent: proxy extent x resolveProxy @ proxy extent y resolveProxy
		depth: proxy depth resolveProxy
		fromArray: (Bitmap resolveVmObjectProxy: proxy bits)
		offset: proxy offset x resolveProxy @ proxy offset y resolveProxy