*Oopsie-upstream:MethodMassage-printing
printLiteralsForAssemblyOn: aStream forEdit: aBoolean
	| literalsToDefine |
	literalsToDefine := literals copy asOrderedCollection.
	(literalsToDefine last isVariableBinding
	 and: [literalsToDefine last value = methodClass]) ifTrue:
		[literalsToDefine removeLast.
		 self assert: (literalsToDefine last ="=" selector
					  or: [literalsToDefine last isMethodProperties
						  and: [literalsToDefine last selector ="=" selector]]).
		 literalsToDefine removeLast].
	literalsToDefine do:
		[:litOrBinding|
		aStream crtab.
		litOrBinding isLiteral
			ifTrue: [aStream nextPutAll: 'literal: '; print: litOrBinding]
			ifFalse:
				[litOrBinding isVariableBinding 
					ifTrue: [aStream nextPutAll: 'binding: '; store: litOrBinding key] 
					ifFalse:
						[litOrBinding isCompiledCode
							ifTrue: [aStream nextPutAll: 'literal: '; print: nil "a post-process pass will fix this"]
							ifFalse:
								[(litOrBinding isBehavior or: [litOrBinding isArray  and: [litOrBinding allSatisfy: [:b | b isBehavior]]])
									ifTrue: [aStream nextPutAll: 'importLiteral: '; nextPutAll: (self importStringFor: litOrBinding)]
									ifFalse:
										[self flag: #todo. "indent nested methods properly; reuse print mode (eg edit)"
										 aStream nextPutAll: 'literal: '.
										 (aBoolean and: [litOrBinding isKindOf: AssemblerMethod])
											ifTrue: [litOrBinding storeAsAssemblerForEditOn: aStream]
											ifFalse:
												[aStream store: litOrBinding] ]]]].
		aStream nextPut: $;]