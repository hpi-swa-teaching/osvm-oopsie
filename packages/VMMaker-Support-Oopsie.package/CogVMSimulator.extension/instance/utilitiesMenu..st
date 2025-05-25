*VMMaker-Support-Oopsie-*VMMakerUI-user interface-override
utilitiesMenu: aMenuMorph
	aMenuMorph
		add: 'toggle transcript' action: #toggleTranscript;
		add: 'deliver interrupt' action: #deliverInterrupt;
		add: 'clone VM' action: #cloneSimulationWindow;
		addLine;
		add: 'print head frame' action: #printHeadFrame;
		add: 'short print head frame & callers' action: [self shortPrintFrameAndCallers: self headFramePointer];
		add: 'long print head frame & callers' action: [self printFrameAndCallers: self headFramePointer SP: self headFramePointer];
		add: 'print frame...' action: [(self promptHex: 'print frame') ifNotNil: [:fp| self printFrame: fp]];
		add: 'inspect frame...' action: [(self promptHex: 'inspect frame') ifNotNil: [:fp| (CogFrameInspector on: self) framePointer: fp; open]];
		add: 'print call stack' action: #printCallStack;
		add: 'print stack call stack' action: #printStackCallStack;
		add: 'print stack call stack of...' action: [(self promptHex: 'frame') ifNotNil: [:fp| self printStackCallStackOf: fp]];
		add: 'print call stack of...' action: [(self promptHex: 'context or process oop') ifNotNil: [:obj| self printCallStackOf: obj]];
		add: 'print call stack of frame...' action: [(self promptHex: 'frame') ifNotNil: [:fp| self printCallStackFP: fp]];
		add: 'print all stacks' action: #printAllStacks;
		add: 'write back local ptrs' action: [stackPointer := localSP. framePointer := localFP. instructionPointer := localIP.
											self writeBackHeadFramePointers];
		add: 'write back mc ptrs' action: [stackPointer := cogit processor sp. framePointer := cogit processor fp. instructionPointer := cogit processor pc.
											self externalWriteBackHeadFramePointers];
		addLine;
		add: 'print rump C stack' action: [self printRumpCStack];
		add: 'print registers' action: [cogit processor printRegistersOn: transcript];
		add: 'print register map' action: [cogit printRegisterMapOn: transcript];
		add: 'disassemble method/trampoline...' action: [(self promptHex: 'pc') ifNotNil: [:pc| cogit disassembleCodeAt: pc]];
		add: 'disassemble method/trampoline at pc' action:
			[cogit disassembleCodeAt: (((cogit codeEntryFor: cogit processor pc) isNil
										  and: [(cogit methodZone methodFor: cogit processor pc) isNil])
											ifTrue: [instructionPointer]
											ifFalse: [cogit processor pc])];
		add: 'disassemble ext head frame method' action: [cogit disassembleMethod: (self mframeCogMethod: self headFramePointer)];
		add: 'print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self printOop: oop]];
		add: 'inspect oop...' action: [(self promptHex: 'inspect oop') ifNotNil: [:oop | self inspectOop: oop]];
		add: 'long print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self longPrintOop: oop]];
		add: 'print context...' action: [(self promptHex: 'print context') ifNotNil: [:oop| self printContext: oop]];
		add: 'symbolic method...' action: [(self promptHex: 'method bytecodes') ifNotNil: [:oop| self symbolicMethod: oop]];
		addLine;
		add: 'inspect object memory' target: objectMemory action: #inspect;
		add: 'run leak checker' action: [Cursor execute showWhile: [self runLeakChecker]];
		add: 'inspect cointerpreter' action: #inspect;
		add: 'inspect cogit' target: cogit action: #inspect;
		add: 'inspect method zone' target: cogit methodZone action: #inspect;
		add: 'inspect head frame' action: [CogHeadFrameInspector openFor: self];
		add: 'inspect processor' action: [CogProcessorAlienInspector openFor: self].
	self isThreadedVM ifTrue:
		[aMenuMorph add: 'inspect thread manager' target: self threadManager action: #inspect].
	aMenuMorph
		addLine;
		add: 'print cog methods' target: cogMethodZone action: #printCogMethods;
		add: 'print cog methods with prim...' action:
			[(self promptNum: 'prim index') ifNotNil: [:pix| cogMethodZone printCogMethodsWithPrimitive: pix]];
		add: 'print cog methods with selector...' action:
			[|s| s := UIManager default request: 'selector'.
			s notEmpty ifTrue:
				[s = 'nil' ifTrue: [s := nil].
				 cogMethodZone methodsDo:
					[:m|
					(s ifNil: [m selector = objectMemory nilObject]
					 ifNotNil: [(objectMemory numBytesOf: m selector) = s size
							and: [(self strncmp: s
											_: (m selector + objectMemory baseHeaderSize)
											_: (objectMemory numBytesOf: m selector)) = 0]]) ifTrue:
						[cogit printCogMethod: m]]]];
		add: 'print cog methods with method...' action:
			[(self promptHex: 'method') ifNotNil: [:methodOop| cogMethodZone printCogMethodsWithMethod: methodOop]];
		add: 'print cog method for...' action: [(self promptHex: 'pc' initialAnswer: (cogit processor pc printStringBase: 16)) ifNotNil:
															[:pc| cogit printCogMethodFor: pc]];
		add: 'print cog method header for...' action: [(self promptHex: 'pc' initialAnswer: (cogit processor pc printStringBase: 16)) ifNotNil:
															[:pc| cogit printCogMethodHeaderFor: pc]];
		add: 'print trampoline table' target: cogit action: #printTrampolineTable;
		add: 'print prim trace log' action: #dumpPrimTraceLog;
		add: 'report recent instructions' target: cogit action: #reportLastNInstructions;
		add: (cogit printRegisters
				ifTrue: ['no print registers each instruction']
				ifFalse: ['print registers each instruction'])
			action: [cogit printRegisters: cogit printRegisters not];
		add: (cogit printInstructions
				ifTrue: ['no print instructions each instruction']
				ifFalse: ['print instructions each instruction'])
			action: [cogit printInstructions: cogit printInstructions not];
		add: (printBytecodeAtEachStep
				ifTrue: ['no print bytecode each bytecode']
				ifFalse: ['print bytecode each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printBytecodeAtEachStep := printBytecodeAtEachStep not];
		add: (printFrameAtEachStep
				ifTrue: ['no print frame each bytecode']
				ifFalse: ['print frame each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printFrameAtEachStep := printFrameAtEachStep not];
		addLine;
		add: (cogit singleStep
				ifTrue: ['no single step']
				ifFalse: ['single step'])
			action: [cogit singleStep: cogit singleStep not];
		add: 'click step' action: [cogit setClickStepBreakBlock];
		add: ((InitializationOptions at: #haltOnExecuteMethod ifAbsent: false)
				ifTrue: [ 'no break on execute method']
				ifFalse: ['break on execute method'])
			action: [InitializationOptions at: #haltOnExecuteMethod put: (InitializationOptions at: #haltOnExecuteMethod) not];
		add: 'set break pc', cogit breakPC menuPrompt, '...-ve to disable or remove' action: [cogit promptForBreakPC];
		add: 'set break count...' action: [|s| s := UIManager default request: 'break count (dec)'.
											s notEmpty ifTrue: [breakCount := Integer readFrom: s readStream]];
		add: 'set break selector...' action: [|s| s := UIManager default request: 'break selector (MNU:foo for MNU)'.
											s notEmpty ifTrue:
												[(s size > 4 and: [s beginsWith: 'MNU:'])
													ifTrue: [self setBreakMNUSelector: (s allButFirst: 4)]
													ifFalse: [self setBreakSelector: s]]];
		add: 'set break block in coInterpreter...' action: [| s |
										s := UIManager default
												request: 'break block'
												initialAnswer: (cogit breakBlock
																ifNotNil: [:bb| bb sourceString copyReplaceAll: 't1' with: 'address']
																ifNil: '[:address| false]').
											s notEmpty ifTrue: [self setBreakBlockFromString: s for: self]];
		add: 'set break block in cogit...' action: [| s |
										s := UIManager default
												request: 'break block'
												initialAnswer: (cogit breakBlock
																ifNotNil: [:bb| bb sourceString copyReplaceAll: 't1' with: 'address']
																ifNil: '[:address| false]').
											s notEmpty ifTrue: [self setBreakBlockFromString: s for: cogit]];
		add: 'set cogit break method...' action: [(self promptHex: 'cogit breakMethod') ifNotNil: [:bm| cogit setBreakMethod: bm]].
	^aMenuMorph