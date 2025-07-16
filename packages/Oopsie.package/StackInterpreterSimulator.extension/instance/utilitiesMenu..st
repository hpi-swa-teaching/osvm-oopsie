*Oopsie-upstream:VMMaker-*VMMakerUI-user interface-override
utilitiesMenu: aMenuMorph
	aMenuMorph
		add: 'send input to stdin' action: #sendInputToStdin;
		add: 'toggle transcript' action: #toggleTranscript;
		add: 'deliver interrupt' action: #deliverInterrupt;
		add: 'clone VM' action: #cloneSimulationWindow;
		addLine;
		add: 'print ext head frame' action: #printExternalHeadFrame;
		add: 'print int head frame' action: #printHeadFrame;
		add: 'short print ext frame & callers' action: [self shortPrintFrameAndCallers: framePointer];
		add: 'short print int frame & callers' action: [self shortPrintFrameAndCallers: localFP];
		add: 'long print ext frame & callers' action: [self printFrameAndCallers: framePointer SP: stackPointer];
		add: 'long print int frame & callers' action: [self printFrameAndCallers: localFP SP: localSP];
		add: 'print frame...' action: [(self promptHex: 'print frame') ifNotNil: [:fp| self printFrame: fp]];
		add: 'inspect frame...' action: [(self promptHex: 'inspect frame') ifNotNil: [:fp| (CogFrameInspector on: self) framePointer: fp; open]];
		add: 'inspect head frame' action: [CogHeadFrameInspector openFor: self];
		add: 'print call stack' action: #printCallStack;
		add: 'print stack call stack' action: #printStackCallStack;
		add: 'print stack call stack of...' action: [(self promptHex: 'frame') ifNotNil: [:fp| self printStackCallStackOf: fp]];
		add: 'print call stack of...' action: [(self promptHex: 'context or process oop') ifNotNil: [:obj| self printCallStackOf: obj]];
		add: 'print call stack of frame...' action: [(self promptHex: 'frame') ifNotNil: [:fp| self printCallStackFP: fp]];
		add: 'print all stacks' action: #printAllStacks;
		add: 'write back local ptrs' action: [stackPointer := localSP. framePointer := localFP. instructionPointer := localIP.
											self writeBackHeadFramePointers];
		add: 'print prim trace log' action: #dumpPrimTraceLog;
		addLine;
		add: 'print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self printOop: oop]];
		add: 'long print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self longPrintOop: oop]];
		add: 'print context...' action: [(self promptHex: 'print context') ifNotNil: [:oop| self printContext: oop]];
		add: 'symbolic method...' action: [(self promptHex: 'method bytecodes') ifNotNil: [:oop| self symbolicMethod: oop]];
		addLine;
		add: 'inspect object memory' target: objectMemory action: #inspect;
		add: 'run leak checker' action: [Cursor execute showWhile: [self runLeakChecker]];
		add: 'inspect interpreter' action: #inspect;
		addLine;
		add: 'click step' action: [self setClickStepBreakBlock];
		add: 'click send' action: [self setClickSendBreakBlock];
		add: ((InitializationOptions at: #haltOnExecuteMethod ifAbsent: false)
				ifTrue: [ 'no break on execute method']
				ifFalse: ['break on execute method'])
			action: [InitializationOptions at: #haltOnExecuteMethod put: (InitializationOptions at: #haltOnExecuteMethod) not];
		add: 'set break count...' action: [|s| s := UIManager default request: 'break count (dec)'.
											s notEmpty ifTrue: [breakCount := Integer readFrom: s readStream]];
		add: 'set break selector...' action: [|s| s := UIManager default request: 'break selector (MNU:foo for MNU)'.
											s notEmpty ifTrue:
												[(s size > 4 and: [s beginsWith: 'MNU:'])
													ifTrue: [self setBreakMNUSelector: (s allButFirst: 4)]
													ifFalse: [self setBreakSelector: s]]];
		add: 'set break block...' action: [| s |
										s := UIManager default
												request: 'break block'
												initialAnswer: (breakBlock ifNotNil: [:bb| bb sourceString] ifNil: '[false]').
											s notEmpty ifTrue: [self setBreakBlockFromString: s]];
		add: 'turn valid exec ptrs assert o', (assertVEPAES ifTrue: ['ff'] ifFalse: ['n']) action: [assertVEPAES := assertVEPAES not];
		add: (printSends
				ifTrue: ['no print sends']
				ifFalse: ['print sends'])
			action: [self ensureDebugAtEachStepBlock.
					printSends := printSends not];
		"currently printReturns does nothing"
		"add: (printReturns
				ifTrue: ['no print returns']
				ifFalse: ['print returns'])
			action: [self ensureDebugAtEachStepBlock.
					printReturns := printReturns not];"
		add: (printBytecodeAtEachStep
				ifTrue: ['no print bytecode each bytecode']
				ifFalse: ['print bytecode each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printBytecodeAtEachStep := printBytecodeAtEachStep not];
		add: (printFrameAtEachStep
				ifTrue: ['no print frame each bytecode']
				ifFalse: ['print frame each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printFrameAtEachStep := printFrameAtEachStep not].
	^aMenuMorph