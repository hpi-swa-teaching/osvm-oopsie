as yet unclassified
todoMoveUpstream
	"
	self todoMoveUpstream
	
	Major concepts to move upstream:
	- external objects
	- symbolicTextWithSendAndBranchData/InstructionPrinterWithSendAndBranchData
	- faster transcript (VMDeferredFlushTranscriptStream)
	- DecoratedAssemblerStyler/YarosX86AsmStyler
	- AssemblerBrowser (see upstream:MethodMassage and implementations of #todoMoveUpstream there)
	
	Overview of external depencies:
	- Required:
		- SimulationStudio: https://github.com/LinqLover/SimulationStudio
	- Optional:
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
								, (self packageInfo classes select: [:ea | ea category includesSubstring: 'upstream'] thenCollect: [:ea | MethodReference class: ea selector: #Definition])
		name: 'Upstream methods of Oopsie'