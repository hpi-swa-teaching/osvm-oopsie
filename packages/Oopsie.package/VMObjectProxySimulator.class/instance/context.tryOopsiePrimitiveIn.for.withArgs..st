private
context: aContext tryOopsiePrimitiveIn: aCompiledMethod for: receiver withArgs: arguments

	| literal |
	literal := aCompiledMethod literalAt: 1.
	^ literal second
		caseOf:
			{[#primitiveObjectMemory] ->
				[^ receiver xxxObjectMemory].
			[#primitiveOop] ->
				[^ receiver xxxOop].
			[#primitiveClass] ->
				[^ aContext objectClass: receiver].
			[#primitivePerformWithArgsUnsimulated] ->
				[^ receiver perform: (arguments atLast: 2) withArguments: arguments last]}
		otherwise: [Context isPrimFailToken: nil]