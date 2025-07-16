*Oopsie
promptExpression: string
	<doNotGenerate>
	^ Project uiManager
		multiLineRequest: string
		centerAt: Sensor cursorPoint
		initialAnswer: ''
		answerHeight: 200