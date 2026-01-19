*Oopsie
visualizeFirstObjects: n
	"
	Do it in the simulator:
		self systemNavigation tryPrimitive: 114 withArgs: #()!
	Then:
		Random seed: 123.
		aSystemNavigationProxy visualizeFirstObjects: 10000
	"

	| sample colorTable colors container |
	sample := self allObjects first: n.
	
	colorTable := Dictionary new.
	colors := Array new: sample size.
	1 to: sample size do: [:index |
		colors at: index put:
			(colorTable
				at: ((sample at: index) ifNotNil: [:x | x vmObjectClass])
				ifAbsentPut: [Color random])].
	container := Morph new extent: sample size sqrt ceiling asInteger asPoint.
	colors withIndexDo: [:color :index |
		container addMorph:
			(Morph new
				position: (index // container width) @ (index \\ container width);
				color: color;
				setProperty: #theObject toValue: (sample at: index);
				on: #mouseDown send: #value to: [ToolSet inspect: (sample at: index)];
				balloonText: ((sample at: index) ifNotNil: [:x | x vmObjectClass]) printString;
				yourself)].
	container openAsMorph.