accessing
vmObjectClassObject 
	"Answer a proxy pointing to the oop of the class of the object represented by the receiver."
	<primitive: #primitiveClass module: #Oopsie>

	^ self class forObjectMemory: self vmObjectMemory oop:
		(self vmObjectMemory fetchClassOf: self vmOop)