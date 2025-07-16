*Oopsie
sendInputToStdin: aString 
	((self detectOrLoadPlugin: 'FilePlugin') openFiles at: 0) queue nextPutAll: aString.