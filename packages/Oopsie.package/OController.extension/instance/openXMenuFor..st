*Oopsie-upstream:MethodMassage-*MethodMassageExtras-Tools-Autocompletion-upstream:Autocompletion-menu morph-override
openXMenuFor: anEditor 
	| class theMenu |
	self closeMenu.
	class := (self model respondsTo: #selectedClassOrMetaClassForAutocompletion)
		ifTrue: [ self model selectedClassOrMetaClassForAutocompletion ]
		ifFalse:
			[ (self model respondsTo: #selectedClassOrMetaClass)
				ifTrue: [ self model selectedClassOrMetaClass ] ].
	context := menuMorph 
		ifNotNil: [menuMorph context] 
		ifNil: [self contextClass 
				controller: self
				class: class
				source: anEditor text string
				position: anEditor startIndex - 1].
	
	self editor: anEditor.
	self expand.
	theMenu := self defaultMenuMorphClass controller: self
				position: (anEditor selectionPosition: context completionToken).
	theMenu isClosed ifFalse: [menuMorph := theMenu].
	menuMorph moveDown; moveDown. 
	