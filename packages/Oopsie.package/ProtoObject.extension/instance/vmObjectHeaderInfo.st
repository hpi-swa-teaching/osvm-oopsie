*Oopsie-tools - inspection
vmObjectHeaderInfo

	| header bits objectMemory oop |
	objectMemory := self vmObjectMemory.
	oop := self vmOop.
	header := objectMemory baseHeader: oop.
	bits := (header printStringBase: 2 length: 64 padded: true) readStream.
	^ Text streamContents: [:stream | | commentAttributes indexAttributes |
		stream withAttribute: TextEmphasis bold do:
			[stream nextPutAll: (header storeStringBase: 16 length: 4 padded: true)].
		stream cr.
		
		(objectMemory isFreeObject: oop) ifTrue:
			[stream nextPutAll: (objectMemory interpreter shortPrint: oop).
			^ stream contents].
		
		commentAttributes := {TextColor color: ((UserInterfaceTheme current get: #comment for: #SHTextStylerST80) first ifNil: [#()]). SHTextStylerST80 enforceItalicEmphasisInComments ifTrue: [TextEmphasis italic] ifFalse: [TextEmphasis normal]}.
		indexAttributes := {TextColor gray}.
		
		{{8. [:nextBits | | numSlots |
			numSlots := objectMemory numSlotsOfAny: oop.
			self assert: (Integer readFrom: nextBits base: 2) = numSlots.
			stream
				nextPutAll: 'numSlots=';
				nextPutAll: numSlots hex;
				nextPutAll: ' (';
				print: numSlots;
				nextPut: $)]}.
		{2. [:nextBits | | isMarked |
			isMarked := objectMemory isMarked: oop.
			self assert: nextBits first asString asNumber = isMarked asBit.
			stream
				nextPutAll: 'isMarked=';
				print: isMarked;
				space;
				nextPutAll: 'unused=';
				print: nextBits second asInteger > 0]}.
		{22. [:nextBits | | identityHash |
			identityHash := objectMemory hashBitsOf: oop.
			self assert: (Integer readFrom: nextBits base: 2) = identityHash.
			stream
				nextPutAll: 'identityHash=';
				print: identityHash]}.
		{3. [:nextBits | | isGrey isPinned isRemembered |
			isGrey := objectMemory isGrey: oop.
			isPinned := objectMemory isPinned: oop.
			isRemembered := objectMemory isRemembered: oop.
			self assert: nextBits first asString asNumber = isGrey asBit.
			self assert: nextBits second asString asNumber = isPinned asBit.
			self assert: nextBits third asString asNumber = isRemembered asBit.
			stream
				nextPutAll: 'isGrey=';
				print: isGrey;
				space;
				nextPutAll: 'isPinned=';
				print: isPinned;
				space;
				nextPutAll: 'isRemembered=';
				print: isRemembered]}.
		{5. [:nextBits | | format |
			format := objectMemory formatOf: oop.
			self assert: format = (Integer readFrom: nextBits base: 2).
			stream
				nextPutAll: 'format=';
				print: format]}.
		{2. [:nextBits | | isImmutable unused |
			isImmutable := objectMemory isImmutable: oop.
			self flag: #todo. "isExtraAligned?"
			unused := nextBits second asString asNumber.
			stream
				nextPutAll: 'isImmutable=';
				print: isImmutable;
				space;
				nextPutAll: 'unused=';
				print: unused]}.
		{22. [:nextBits | | classIndex |
			classIndex := objectMemory classIndexOf: oop.
			self assert: classIndex = (Integer readFrom: nextBits base: 2).
			stream
				nextPutAll: 'classIndex=';
				withAttribute: (TextInspectIt on: self vmObjectClassObject) do:
					[stream nextPutAll: classIndex hex]]}}
			do: [:sizeAndBlock |
				| index nextBits |
				index := bits position.
				nextBits := bits next: sizeAndBlock first.
				stream
					withAttributes: indexAttributes do:
						[stream
							print: index;
							nextPut: $:];
					tab;
					nextPutAll: nextBits;
					tab;
					withAttributes: commentAttributes do:
						[sizeAndBlock second value: nextBits]]
			separatedBy: [stream cr]]