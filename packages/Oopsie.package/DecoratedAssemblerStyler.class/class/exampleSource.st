examples
exampleSource

	^
"Language=DecoratedAssembler assemblerLanguage: #X86Asm"
'C5450
	objhdr: 8000000A000035
	nArgs: 0	type: 5 CMMethod
	blksiz: 1E0
	method: 1EEC4D0 in Integer
	mthhdr: 8000000000000021
	selctr: BFD968 #benchFib
	blkentry: 0
	stackCheckOffset: 78/C54C8
	cmRefersToYoung: no	cmHasMovableLiteral: no	cmIsFullBlock: no
	counters: 
000c5480: xorq %rdx, %rdx : 48 31 D2 
000c5483: call .-0xC4BE0 (0x8a8=ceMethodAbort0Args) : E8 20 B4 F3 FF 
entry:
000c5488: movq %rdx, %rax : 48 89 D0 
000c548b: andq $0x7, %rax : 48 83 E0 07 
000c548f: jnz .+0x9 (.+004A) : 75 09 
000c5491: movq (%rdx), %rax : 48 8B 02 
000c5494: andq $0x3fffff, %rax : 48 25 FF FF 3F 00 
000c549a: cmpq %rcx, %rax : 48 39 C8 
000c549d: jnz .-0x1C (.+0033) : 75 E4 
noCheckEntry:
000c549f: movq (%rsp), %r9 : 4C 8B 0C 24 
000c54a3: movq %rdx, (%rsp) : 48 89 14 24 
000c54a7: pushq %r9 : 41 51 '