*Oopsie-upstream:VMMaker-accessing-override
next
	"Answer the next object in the Stream represented by the receiver.
	 If there are no more elements in the stream fill up the buffer by prompting for input"
	self assureNotEmpty.
	^ collection at: (position := position + 1)
	

" This does it with workspaces:
| ws r s |
s := Semaphore new.
ws := Workspace new contents: ''.
ws acceptAction: [:t| r := t asString. s signal].
[ws openLabel: 'Yo!'; shouldStyle: false.
(ws dependents detect: [:dep | dep isKindOf: PluggableTextMorph] ifNone: [nil]) ifNotNil:
	[:textMorph| textMorph acceptOnCR: true; hasUnacceptedEdits: true]] fork.
Processor activeProcess ==  Project uiProcess
	ifTrue: [[r isNil] whileTrue: [World doOneCycle]]
	ifFalse: [s wait].
ws topView delete.
s wait. s signal.
r"