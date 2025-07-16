*Oopsie-upstream:VMMaker-*VMMakerUI-InterpreterSimulation-Morphic-override
openAsMorph
	"Open a morphic view on this simulation."
	| localImageName borderWidth window |
	localImageName := imageName
							ifNotNil: [self localNameFor: imageName]
							ifNil: [' synthetic image'].
	window := (SystemWindow labelled: 'Simulation of ', localImageName) model: self.
	window paneColor: self windowColorToUse.

	window addMorph: (displayView := SimulatorImageMorph new image: displayForm)
			frame: (0@0 corner: 1@0.8).
	displayView activeHand addEventListener: self.
	eventTransformer := SimulatorEventTransformer new.

	transcript := VMDeferredFlushTranscriptStream onTranscript: (TranscriptStream on: (String new: 10000)).
	window addMorph: (PluggableTextMorph
							on: transcript innerTranscript text: nil accept: nil
							readSelection: nil menu: #codePaneMenu:shifted:)
			frame: (0@0.8 corner: 0.7@1).
	window addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil
						readSelection: nil menu: #utilitiesMenu:) hideScrollBarsIndefinitely
			frame: (0.7@0.8 corner: 1@1).

	borderWidth := [SystemWindow borderWidth] "Squeak 4.1"
						on: MessageNotUnderstood
						do: [:ex| 0]. "3.8"
	borderWidth := borderWidth + window borderWidth.
	window openInWorldExtent: (self desiredDisplayExtent
								+ (2 * borderWidth @ borderWidth)
								+ (0@window labelHeight)
								* (1@(1/0.8))) rounded.
	^window