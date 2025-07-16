as yet unclassified
todoMoveUpstream
	"
	self todoMoveUpstream
	
	Concepts to move upstream:
	- external objects
	- symbolicTextWithSendAndBranchData
	"

	^ self systemNavigation
		browseMessageList:
			(((self systemNavigation allCallsOn: #moveUpstream localToPackage: self packageInfo)
				, ((self systemNavigation allExtensionMethodsOfPackage: self packageInfo)
					select: [:ea | ea category includesSubstring: 'upstream']))
						withoutDuplicates
							copyWithout: thisContext method asCodeReference)
								, (self packageInfo classes select: [:ea | ea category includesSubstring: 'upstream'] thenCollect: [:ea | ea asCodeReference])
		name: 'Upstream methods of Oopsie'