*VMMaker-Support-Oopsie
resolveProxyColorMap

	| data |
	nil haltIf: self className ~= #Bitmap.
	data := self in: [:bitmap | bitmap compressToByteArray base64Encoded].
	^ Bitmap decompressFromByteArray: (data yarosBase64DecodedAs: ByteArray)