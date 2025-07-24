*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-toolbuilder-override
contentsSymbolQuints

	^ super contentsSymbolQuints select: [:quint |
		#(source byteCodes
			assembler
		) includes: quint first]