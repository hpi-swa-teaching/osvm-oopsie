*Oopsie-upstream:MethodMassage-*MethodMassage-Tools-upstream:Trunk-evaluating-pseudo-override
acceptContents: aStringOrText for: anInspector notifying: requestor

	^ self acceptBlock cull: anInspector object cull: aStringOrText cull: requestor cull: anInspector