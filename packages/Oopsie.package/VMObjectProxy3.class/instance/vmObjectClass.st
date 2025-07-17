accessing
vmObjectClass
	"Answer the class in the host image that corresponds to the class of the proxied object represented by the receiver. If that exact class is not available, fall back to a sane default."

	((self vmObjectMemory isImmediate: self vmOop) not and: [self vmObjectMemory isFreeObject: self vmOop]) ifTrue: [^ UndefinedObject].
	^ (self vmObjectClassFor: (self vmObjectMemory fetchClassOf: self vmOop))
		ifNil: [Object]