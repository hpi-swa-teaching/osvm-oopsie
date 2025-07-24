*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-accessing - contents-override
contents: aString notifying: aController
	"Try to change the contents of the selected field. This is the usual callback for all string holders."
	
	| result |
	self selectedField ifNotNil: [:field |
		field hasAcceptBlock ifTrue: [
			"could be reused for CompiledMethodInspector>>fieldSource; could be generalized further to also allow custom compilation but passing result to #replaceSelectionValue:"
			^ (field acceptContents: aString for: self notifying: aController)
				in: [:res | res == true ifTrue: [
					self contentsTyped: nil. "Ensure to refresh the contents view."
					(self valuePane respondsTo: #hasUserEdited:) ifTrue: [self valuePane hasUserEdited: false] "if we have stepped after the last keyboard event (e.g., during an open dialog), updateFields may have set hasUserEdited to true"]];
				yourself].
		
		field isReadOnly ifTrue: [
			self inform: 'You cannot replace the selected field because\it is read-only. Try to add a field setter.' withCRs translated.
		^ false]].
	
	result := self object class evaluatorClass new
		evaluate: aString
		in: self doItContext
		to: self doItReceiver
		notifying: aController
		ifFail: [^ false].
	
	^ (self replaceSelectionValue: result)
		in: [:res | res == true ifTrue: [
			(self valuePane respondsTo: #hasUserEdited:) ifTrue: [self valuePane hasUserEdited: false] "if we have stepped after the last keyboard event (e.g., during an open dialog), updateFields may have set hasUserEdited to true"]];
		yourself