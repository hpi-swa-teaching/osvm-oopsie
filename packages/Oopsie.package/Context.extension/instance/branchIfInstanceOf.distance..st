*Oopsie-upstream:Scorching
branchIfInstanceOf: literal distance: dist

	self flag: #moveUpstream. "depends on: resolveProxy"
	(self objectClass: self pop) == literal resolveProxy ifTrue:
		[self jump: dist].