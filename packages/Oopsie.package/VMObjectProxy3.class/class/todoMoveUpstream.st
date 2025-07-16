as yet unclassified
todoMoveUpstream
	"
	self todoMoveUpstream
	
	Concepts to move upstream:
	- external objects
	- symbolicTextWithSendAndBranchData
	
	Overview of external depencies:
	- resolveProxy (required methods are contained in upstreamCompat:resolveProxy categories): https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/Z7WDON3FBX6YOKRC4SW5NGN4HQXVP73Z/#Z7WDON3FBX6YOKRC4SW5NGN4HQXVP73Z
	- InstructionPrinter with style (required methods are contained in upstreamCompat:InstructionPrinter with style categories): https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/DDBGAVASGZW7GAYVXUXOQNOPDTBP4QIP/
	- YarosStyler for styled assembler code (optional dependency, otherwise assembler will not be fully styled): https://github.com/LinqLover/yaros/ (NOTE: YarosStyler is not yet committed!)
	"
	self flag: #todo. "commit YarosStyler"

	^ self systemNavigation
		browseMessageList:
			(((self systemNavigation allCallsOn: #moveUpstream localToPackage: self packageInfo)
				, ((self systemNavigation allExtensionMethodsOfPackage: self packageInfo)
					select: [:ea | ea category includesSubstring: 'upstream']))
						withoutDuplicates
							copyWithout: thisContext method asCodeReference)
								, (self packageInfo classes select: [:ea | ea category includesSubstring: 'upstream'] thenCollect: [:ea | ea asCodeReference])
		name: 'Upstream methods of Oopsie'