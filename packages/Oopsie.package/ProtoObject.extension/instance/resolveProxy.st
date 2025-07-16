*Oopsie-upstreamCompat:resolveProxy-proxy-override
resolveProxy
	"If the receiver is a proxy, resolve the receiver into the underlying object, otherwise return self.
	When a transparent proxy is passed to a primitive that cannot handle it, the fallback code of the primitive method should send this message and then retry the primitive with the resolved result. Occasionally, also non-primitive methods may send this message to prefetch data as an optimization (e.g., to avoid resolving proxies during every rendering cycle). However, as a general rule, proxies should be resolved as late as possible to retain a live reference to the underlying data. For additional context, read the second section of Object class howToModifyPrimitives.
	
	Notes for implementors:
	
	Generally speaking, there are two types of transparent proxies that need to consider different implementation strategies for this method:
	1) Decorating proxies (such as ObjectTracer) forward all messages to another object in the same image. Usually, they can simply answer that underlying object for primitive resolution.
	2) Materializing proxies (such as YarosRemoteObject [1] or VMObjectProxy2 [2]) handle all messages by executing them in a separate environment and often answer other proxies as a result. For resolution, they typically need to disassemble/serialize the object they represent into transmissible parts and then reassemble/deserialize them. Implementors may need to check the type/class of the object for practical serialization strategies (e.g., immediate objects can simply be serialized to Json, while Forms/Bitmaps can be shared more efficiently via a compressed stream).
		Essential types for that resolution must be supported for resolution are: {Array. Behavior. Boolean. Character. CompiledMethod*. SmallInteger. String}
			* If the proxy implements #run:with:in: for the Objects as Methods protocol, CompiledMethod resolution does not need to be supported.
		For Graphics: {Bitmap. Color. Form}
	
	(Design note: In many cases, the type of the represented object would already seem obvious from the context of the failing primitive method---e.g., Object>>at: could also send a more specific #resolveIntegerProxy, sparing proxies from the need to (potentially costly) type check on their own. However, per general execution semantics any primitive method can be executed with any types of arguments (e.g., 'hi' at: 1s1), so such an optimization would not be safe.)
	
	[1] Yaros: https://github.com/LinqLover/yaros
	[2] Oopsie for VMMaker (not yet released)"

	^ self