*VMMaker-Support-Oopsie-override
selectedBytecodes
	"Answer text to show in a code pane when in showing-byte-codes mode"

	^ (self selectedClassOrMetaClass compiledMethodAt: self selectedMessageName ifAbsent: [^ '' asText]) symbolicTextWithSignature