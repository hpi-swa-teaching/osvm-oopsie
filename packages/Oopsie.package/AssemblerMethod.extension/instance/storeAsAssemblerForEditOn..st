*Oopsie-upstream:MethodMassage-private
storeAsAssemblerForEditOn: aStream
	| string |
	string := String streamContents: [:stream | self printAsAssemblerOn: stream].
	string := string copyReplaceAll: String tab with: String tab , String tab.
	aStream nextPutAll: string.