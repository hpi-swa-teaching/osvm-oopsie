*Oopsie-scorching-override
ceSistaTrap
	"When we arrive here, the value that trapped is pushed on stack"
	<api>
	<option: #SistaVM>
	instructionPointer := self popStack.
	self respondToSistaTrap.