*VMMaker-Support-Oopsie
sendInputToStdin: aString 
	| filePlugin |
	filePlugin := (self pluginList detect: [:each | each key = 'FilePlugin']) value.
	(filePlugin openFiles at: 0) queue nextPutAll: aString.