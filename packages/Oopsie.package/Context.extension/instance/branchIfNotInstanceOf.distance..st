*Oopsie-upstream:Scorching
branchIfNotInstanceOf: literal distance: dist

	self flag: #moveUpstream. "depends on: resolveProxy"
	(self objectClass: self pop) == literal resolveProxy ifFalse:
		[self jump: dist].