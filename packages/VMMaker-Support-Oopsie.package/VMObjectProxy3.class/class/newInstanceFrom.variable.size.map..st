private
newInstanceFrom: oldInstance variable: variable size: instSize map: map
	"Create a new instance of the receiver based on the given old instance.
	The supplied map contains a mapping of the old instVar names into
	the receiver's instVars"
	| new |
	variable
		ifTrue: [new := self basicNew: (thisContext objectSize: oldInstance)]
		ifFalse: [new := self basicNew].
	1 to: instSize do: 
		[:offset |  (map at: offset) > 0 ifTrue:
			[thisContext object: new instVarAt: offset
					put: (thisContext object: oldInstance instVarAt: (map at: offset))]].
	variable 
		ifTrue: [1 to: (thisContext objectSize: oldInstance) do: 
					[:offset |
					thisContext object: new basicAt: offset put: (thisContext object: oldInstance basicAt: offset)]].
	^new