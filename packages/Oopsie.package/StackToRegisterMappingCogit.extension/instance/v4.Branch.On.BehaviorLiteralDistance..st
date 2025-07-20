*Oopsie-upstream:VMMaker-span functions
v4: descriptor Branch: pc On: nExts BehaviorLiteralDistance: aMethodObj
	"**	254	(5)	11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior literal kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0 and <= 127)
	**	254	(5)	11111110	kkkkkkkk	jjjjjjjj		branch If Instance Of Behavior/Array Of Behavior literal kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ (Extend B bitAnd: 127) * 256, where Extend B >= 128 and <= 255)"
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| extBValue |
	self assert: nExts >= 0.
	self parseV4Exts: nExts priorTo: pc in: aMethodObj into: [:ea :eb| extBValue := eb].
	^(objectMemory fetchByte: pc + 2 ofObject: aMethodObj)
	+ ((extBValue bitAnd: 127) << 8)