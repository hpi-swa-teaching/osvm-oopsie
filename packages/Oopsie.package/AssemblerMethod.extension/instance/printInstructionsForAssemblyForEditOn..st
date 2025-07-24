*Oopsie-upstream:MethodMassage-printing
printInstructionsForAssemblyForEditOn: aStream
	instructions do:
		[:messageOrLabel|
		aStream cr.
		(self isLabel: messageOrLabel)
			ifTrue:
				[aStream
					cr;
					nextPutAll: 'self label: '; print: messageOrLabel key]
			ifFalse:
				[aStream nextPutAll: 'self '.
				 messageOrLabel numArgs = 0
					ifTrue: [aStream nextPutAll: messageOrLabel selector]
					ifFalse:
						[messageOrLabel selector keywords with: messageOrLabel arguments do:
							[:kwd :arg|
							aStream nextPutAll: kwd; space.
							aStream print: ((kwd = 'jump:' or: [kwd = 'blockSize:' or: [kwd = 'distance:']])
												ifTrue: [self assert: (self isLabel: arg).
														arg key]
												ifFalse: [arg]); space].
						aStream skip: -1]].
		aStream nextPut: $.]