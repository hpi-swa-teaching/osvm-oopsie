*VMMaker-Support-Oopsie
ceSistaTrap
	"When we arrive here, the value that trapped is pushed on stack"
	<api>
	<option: #SistaVM>
	| context |
	context :=
		[instructionPointer := self popStack.
		self proxyForOop: (self ensureFrameIsMarried: framePointer SP: stackPointer)]
			ensure: [self push: instructionPointer].
	(Context >> (Smalltalk specialObjectsArray at: SelectorSistaTrap + 1) valueWithReceiver: context arguments: #()).
	self halt.