*Oopsie-upstreamCompat:resolveProxy-proxy-override
isProxy
	"Answers whether the receiver is a transparent proxy to another object. If yes, many primitive methods will send #resolveProxy to the receiver when their fallback code encounters a proxy argument that the VM cannot handle."

	^ false