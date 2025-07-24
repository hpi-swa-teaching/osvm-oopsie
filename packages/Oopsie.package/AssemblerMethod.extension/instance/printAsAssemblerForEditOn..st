*Oopsie-upstream:MethodMassage-private
printAsAssemblerForEditOn: aStream
	| convertBlock |
	convertBlock := [:printBlock |
		| string |
		string := String streamContents: [:stream | printBlock value: stream].
		string ifNotEmpty:
			[aStream nextPutAll:
				((string copyWithRegex: '(?<!.)' matchesReplacedWith: 'self')
					copyWithRegex: ';(?!.)' matchesReplacedWith: '.').
			aStream cr]].
	
	convertBlock value: [:stream | self printAccessorsForAssemblyOn: stream].
	convertBlock value: [:stream | self printLiteralsForAssemblyOn: stream forEdit: true].
	aStream cr.
	self printInstructionsForAssemblyForEditOn: aStream.