*VMMaker-Support-Oopsie
yarosBase64DecodedAs: aClass
	"Decode the receiver from base 64 into an instance of aClass."

	self flag: #todo. "convertr changes not yet commited!"
	^ Base64MimeConverter mimeDecode: self as: aClass