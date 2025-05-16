as yet unclassified
vmClassObject

	^ self vmObjectDo: [:objectMemory :oop |
		self vmObjectClassFor: oop]