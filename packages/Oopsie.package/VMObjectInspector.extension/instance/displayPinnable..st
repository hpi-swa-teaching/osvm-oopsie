*Oopsie-upstream:VMMaker-accessing - ui-override
displayPinnable: title
	"Assuming the receiver is not yet open, inform the user with the receiver's text,
	 including a 'Pin' button.  If the user chooses 'Pin' open the receiver permanently."
	(UserDialogBoxMorph new
		title: title;
		message: self text;
		createButton: 'OK' translated value: nil;
		createButton: 'PIN' translated value: #pin;
		getUserResponseAtHand) = #pin ifTrue:
			[self openPinned]