*Oopsie-upstream:VMMaker-debug printing
printHex: n on: aStream
	"Print n in hex,  in the form '    0x1234', padded to a width of 10 characters
	 in 32-bits ('0x' + 8 nibbles) or 18 characters in 64-bits ('0x' + 16 nibbles).
	 In the simulator use 16r as the prefix, padding to 11 characters in 32-bits
	 or 19 characters in 64-bits."
	<api>
	<var: #n type: #usqInt>
	<inline: false>
	(self pst: '%WP') f: aStream printf: n asVoidPointer