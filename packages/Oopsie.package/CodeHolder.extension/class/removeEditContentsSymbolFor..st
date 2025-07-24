*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-controls
removeEditContentsSymbolFor: aSymbol

	"CodeHolder removeEditContentsSymbolFor: #translateToC"

	EditContentsOptions removeKey: aSymbol ifAbsent: nil.