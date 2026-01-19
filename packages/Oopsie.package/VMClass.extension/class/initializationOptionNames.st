*Oopsie-upstream:VMMaker-documentation-override
initializationOptionNames
	"self initializationOptionNames"
	| names initializationOptionsBinding |
	names := Set new.
	initializationOptionsBinding := self bindingOf: #InitializationOptions.
	(self systemNavigation allCallsOn: initializationOptionsBinding localTo: VMClass) do:
		[:methodReference|
		methodReference compiledMethod methodNode nodesDo:
			[:node|
			(node isMessageNode
			 and: [node receiver notNil "cascades..."
			 and: [node receiver isVariableNode
			 and: [node receiver key == initializationOptionsBinding
			 and: [node arguments notEmpty
			 and: [node arguments first isLiteralNode]]]]]) ifTrue:
				[names add: node arguments first key]]].
	^names sorted
						
	"Here is a list of the keys, categorized as system configuration, launch configuration, breakpointing options, Slang testing options, and options computed during initialization (i.e. not usefully settable by the user).
	 The best documentation is the source code which can be browsed selectively by e.g.
		self systemNavigation browseAllCallsOn: (VMClass bindingOf: #InitializationOptions) and: #bytecodeTableInitializer (your option goes here)
	 V3 refers to the original BTTF VM's bytecode set and object representation/GC
	 Spur refers to Eliot Miranda's lazy forwarding/class indices based object representation/GC
	 Sista refers to Clément Béra and Eliot Miranda's bytecode set and/or system architecture for adaptive optimization
	 lemming debugging refers to running GCs in a copy of the system before running them in the real system so that bugs in GCs can be analysed since the original heap is undisturbed if the GC in the copy crashes

	System Configuration
	#ObjectMemory					required	Symbol		(see below)					class name of object representation/GC
	#IMMUTABILITY					optional	Boolean	SPURVM						if true check immutability on all stores (default true in Spur, false in V3)
	#MULTIPLEBYTECODESETS		optional	Boolean	false							if true support two bytecode sets (default V3PlusClosures & SistaV1), if false will support V3PlusClosures
	#LowcodeVM						optional	Boolean	false							if true support Ronie Salgado's in-line primitives for C/ABI access
	#NewspeakVM					optional	Boolean	false							if true use Newspeak bytecode support and send semantics
	#EnforceAccessControl			optional	Boolean	true							in Newspeak VMs defines whether method access control is enforced
	#bytecodeTableInitializer			optional	Symbol		initializeBytecodeTableFor*	message sent to initialize bytecode table(s) in interpreter and JIT

	StackInterpreter System Configuration
	#ObjectMemory					required	Symbol		NewObjectMemory, Spur32BitMemoryManager, Spur64BitMemoryManager
	#FailImbalancedPrimitives		optional	Boolean	true	if true primitive invocation will check for a valid stack depth around a primitive call and fail calls that set the stack depth incorrectly
	#TempVectReadBarrier			optional	Boolean	false	if true any access to a temporary indirection vector (part of the closure implementation) will involve a read barrier (Spur only). A read barrier would be needed if temp vectors would be becommed/pinned etc, and following of forwarders in the stack zone follows only the receiver. See followForwardingPointersOfReceiverAndTemporariesInStackZone experiment
	#PharoVM							optional	Boolean	false	if true include some PharoVM variations in V3 weak reference management and FilePlugin primitives

	Cog System Configuration
	#ObjectMemory						required	Symbol		NewCoObjectMemory, Spur32BitCoMemoryManager, Spur64BitCoMemoryManager
	#Cogit									required	Symbol		SimpleStackBasedCogit, StackToRegisterMappingCogit, SistaCogit, RegisterAllocatingCogit class name of Cogit class to use
	#ISA									required	Symbol		32-bit: ARMv5, IA32 64-bit: ARMv8, X64
	#COGMTVM							optional	Boolean	false	if true configure as threading VM via disownVM: ownVM:
	#SistaVM								optional	Boolean	false	if true include adaptive optimization support
	#CheckRememberedInTrampoline	optional	Boolean	false	if true check the remembered bit in the trampolines not inline code in the Spur store check
	#MaxLiteralCountForCompile			optional	Integer				if true defines the number of literals beyond which methods will not be JITted
	#Debug								optional	Boolean	false	if true includes additional debugging facilities in the Cogit (principally a wrapper around the enilopmarts for breakpointing entry into machine code in the real VM)

	#ABI								optional	Symbol		SysV WIN64/_WIN64 ABI to use for run-time calls on x64 (x86_64) platform
	#DUAL_MAPPED_CODE_ZONE		optional	Boolean	false	if set, code zone configured with dual mapping, one for read-execute, one for read-write
	#nonVarBaseVariables			optional	Array of String		if set, array of CoInterpreter inst var names not to access via VarBaseReg

	Spur Configuration
	#ExpensiveAsserts				optional	Boolean	false	if set, include some very slow assert checks in the Spur object stack implementation (used for mark stack, etc)
	#compactorClass					optional	Symbol		SpurPlanningCompactor (default), SpurSelectiveCompactor, SpurHybridCompactor	class name of Spur compactor

	Launch Configuration
	#builtinModules					optional	Array of String		if set, array of names of primitive plugin modules to consider as built-in to the VM
	#entropy							optional	ByteArray			if set provides the seed of the CroquetPlugin's RNG
	#ioScreenScaleFactor				optional	Float				if set defines the display screen scale factor
	#profiling							optional	Boolean			if true turns on VM profiling from the get-go (for testing JIT)
	#profileIncrement					optional	Integer				if set, defines how fast the profiling clock advances
	#startMicroseconds				optional	Integer				if set, defines the value of the microsecond clock at startup
	#initialStdinContents				optional	String or Array of String	if set, provides initial stdin input once the image reads it

	Simulation Configuration
	#ByteCountsPerMicrosecond		optional	Integer				if set, defines how fast the byteCount advances relative to the simulated microsecond clock
	#CheckStackDepth				optional	Boolean	true	if true turns on checking of Smalltalk stack depth in various run-time routines called from machine code (send lookup routines, aborts, etc)
	#CloneOnGC						optional	Boolean	true	if true turns on lemming debugging of global GCs
	#CloneOnScavenge				optional	Boolean	true	if true turns on lemming debugging of scavenging GCs (Spur only)
	#DoNotJIT							optional	Array of Integer	if set lists the selector oops, and/or primitive indices of methods not to jit
	#MaxFileDescriptors				optional	Integer				if set, defines how many file descriptors the FilePlugin will provide
	#UseMultiProcessor				optional	Boolean	false	if true, use the MultiProcessor wrapper around the processor when simulating a COGMTVM
	#disableOSProcess				optional	Boolean	false	if true, tries to avoid unsimulatable code in the OSProcessPlugin to allow images using OSProcess to simulate
	#desiredCogCodeSize				optional	Integer				if set, overrides the default cog code size (mimics command-line setting in real VM)
	#desiredEdenBytes				optional	Integer				if set, overrides the default eden size (mimics command-line setting in real VM)
	#desiredNumStackPages			optional	Integer				if set, overrides the default number of stack zone pages (mimics command-line setting in real VM)
	#isCFramePointerInUse			optional	Boolean	true	if false, does not save/restpore the frame pointer register in generated trampolines in the Cogit
	#nInstructionsLimit				optional	Integer				max number of instructions remembered when single-stepping; defaults to 320
	#sistaSimulatedSelectorCounterTripped	optional	Symbol		If set, delegates counter trips in a Sista VM to the host image by sending the symbol to an Oopsie proxy on the oop of the counter-tripping context. The simulated VM can still control whether counter trips should be handled by setting Smalltalk specialObjectsArray at: 59 to nil.
	#sistaSimulatedSelectorTrap			optional		Symbol		If set, delegates traps in a Sista VM to the host image by sending the symbol to an Oopsie proxy on the oop of the trapping context.

	Simulation/In-Image Compilation Break Pointing
	#haltOnExecuteMethod			optional	Boolean	true	if true the VM will break in primitiveExecuteMethod[ArgsArray]
	#haltOnFileDelete					optional	Boolean	true	if true the FilePlugin will break before deleting any file
	#haltOnCounterTripped			optional	Boolean|true	if true the VM will break in ceCounterTripped:
	#linkedSendTrace					optional	Integer				sets the Cogit's trace flags (mimics command-line setting in real VM)
	#recordPrimTrace					optional	Boolean	true	sets the trace primitive calls bit in the Cogit's trace flags
	#relativeAddressDisassembly		optional	Boolean	false	disassembles machine code using relative addresses
	#disassemblyBreakPC			optional	Integer				if set, specifies the machine code instruction at which to break during method/trampoline disassembly
	#breakPC							optional	Integer				if set, specifies the machine code instruction or bytecode address at which to break
	#compilationTrace				optional	Integer				sets the Cogit's compilation trace flags
	#debugBytecodePointers			optional	Set of Integer		sets the bytecode PCs at which JIT compilation will break *in the breakMethod if set*
	#debugFixupBreaks				optional	Set of Integer		sets the fixup instruction indexes at which JIT compilation will break *in the breakMethod if set*
	#debugOpcodeIndices			optional	Set of Integer		sets the abstract instruction indexes at which JIT compilation will break *in the breakMethod if set* (cf instructionIndex)
	#haltOnFailingTruncate			optional	Boolean	false	halts if the BoxedFloat64 truncate primitive fails. ASs of 12/2025 there are issues with truncate on 32-bit Spur
	#instructionAddress				optional	Integer				sets the address containing an abstract instruction at which JIT compilation will break *in the breakMethod if set*
	#instructionIndex					optional	Integer or Set there-of		sets the index(s) of abstract instruction(s) at which JIT compilation will break (cf debugOpcodeIndices)

	Slang Testing:
	Any compile-time parameter (see VMBasicConstants class>>defineAtCompileTime:) can be overridden in InitializationOptions

	Computed:
	#COGVM									Boolean	true if a CogVM
	#CogCompilerClass						Symbol		CogARMv8Compiler, CogIA32Compiler, CogX64Compiler, CogOutOfLineLiteralsARMCompiler, CogInLineLiteralsX64Compiler 
	#NewsqueakV4BytecodeSet				Boolean	true if NewsqueakV4 bytecode set is in the VM
	#SistaV1BytecodeSet						Boolean	true if SistaV1 bytecode set is in the VM
	#Spur32BitMemoryManager				Boolean	true if 32-bit Spur
	#Spur64BitMemoryManager				Boolean	true if 64-bit Spur
	#SpurObjectMemory						Boolean	true if Spur (as opposed to V3)
	#SqueakV3ObjectMemory				Boolean	true if V3 (as opposed to Spur)
	#SqueakV3PlusClosuresBytecodeSet		Boolean	true if V3PlusClosures bytecode set is in the VM
	#instVarNames							Array of String		array of methodClass inst var names used in disassembly decoration of in-image compilations
	#numArgs									Integer				arg count of block used to get correct temp var names used in disassembly decoration of in-image compilations of embedded block methods
	#startpc									Integer				startpc of block used to get correct temp var names used in disassembly decoration of in-image compilations of  embedded block methods
	#tempNames								Array of String		array of method temp var names used in disassembly decoration of in-image compilations
	"