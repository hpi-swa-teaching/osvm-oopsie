*Oopsie
branchIfInstanceOf: literal distance: dist

	(self objectClass: self pop) == literal resolveProxy ifTrue:
		[self jump: dist].