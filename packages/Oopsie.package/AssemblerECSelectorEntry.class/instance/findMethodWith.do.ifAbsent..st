private
findMethodWith: anECContext do: foundBlock ifAbsent: notfoundBlock 
	| result |
	result := (self lookupSelector: contents class: anECContext model preferedDescriptionClass)
		ifNil:
			[(anECContext model theClass ifNotNil: [:class | self lookupSelector: contents class: class])
				ifNil:
					[(self lookupSelector: contents class: anECContext model alternativeDescriptionClass)
						ifNil: [^ notfoundBlock value: contents]]]. 
	^ foundBlock value: result first value: result second