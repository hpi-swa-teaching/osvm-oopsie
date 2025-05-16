*VMMaker-Support-Oopsie
addAllAttributes: attributes unless: aBlock

	attributes do: [:attribute |
		self addAttribute: attribute unless: aBlock].