class initialization
initialize

	Mirror := thisContext.
	VMPrimitives := (Array new: 578 withAll: true)
		atAll:
			(201 to: 222) "block closures"
				, #(83 84 100) "perform"
				, #(188 189) "executeMethod"
				, #(117) "primitiveExternalCall"
				, #(118) "tryPrimitive"
				, (256 to: 263) "quick prims"
			put: false;
		yourself.