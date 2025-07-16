proxy
resolveProxyForm

	^ Form
		extent: self extent x @ self extent y
		depth: self depth
		fromArray: (Bitmap decompressFromByteArray: ((self bits compressToByteArray base64Encoded) base64Decoded asByteArray))
		offset: self offset x @ self offset y