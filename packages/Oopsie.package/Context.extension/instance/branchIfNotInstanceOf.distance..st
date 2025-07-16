*Oopsie
branchIfNotInstanceOf: literal distance: dist

	(self objectClass: self pop) == literal resolveProxy ifFalse:
		[self jump: dist].