as yet unclassified
todoMoveUpstream
	"
	self todoMoveUpstream
	"

	| ignorePrefix packageInfos |
	ignorePrefix := [:cat |
		| prefix start |
		prefix := 'Oopsie-upstream'.
		(start := cat findString: prefix) > 0
			ifTrue: [cat allButFirst: start + prefix size]
			ifFalse: [cat]].
	packageInfos := {PackageInfo new packageName: self category. PackageInfo new packageName: 'Oopsie-upstream:MethodMassage-*MethodMassage-Tools'}.
	^ self systemNavigation
		browseMessageList:
			(packageInfos gather: [:p |
				(((self systemNavigation allCallsOn: #moveUpstream localToPackage: p)
					, ((self systemNavigation allExtensionMethodsOfPackage: p)
						select: [:ea | (ignorePrefix value: ea category) includesSubstring: 'upstream']))
							withoutDuplicates
								copyWithout: thisContext method asCodeReference)
									, (p classes select: [:ea | (ignorePrefix value: ea category) includesSubstring: 'upstream'] thenCollect: [:ea | ea asCodeReference])])
		name: 'Upstream methods of MethodMassage-Tools'