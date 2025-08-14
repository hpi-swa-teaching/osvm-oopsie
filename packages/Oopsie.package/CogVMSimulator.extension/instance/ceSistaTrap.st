*Oopsie-scorching
ceSistaTrap
	"When we arrive here, the value that trapped is pushed on stack"
	<api>
	<option: #SistaVM>
	self transcript cr; nextPutAll: 'sista trap in '.
	self shortPrintFrame: framePointer.
	instructionPointer := self popStack.
	self respondToSistaTrap.