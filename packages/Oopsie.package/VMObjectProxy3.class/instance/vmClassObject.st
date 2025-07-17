accessing
vmClassObject
	"Assuming that the proxied oop represented by the receiver points to a class, answer the corresponding class in the host image."

	^ self vmObjectClassFor: self vmOop