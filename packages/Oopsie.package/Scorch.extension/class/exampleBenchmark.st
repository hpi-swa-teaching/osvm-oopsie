*Oopsie-documentation
exampleBenchmark

	"The image must:
	1) have installed Scorch
	2) have set Smalltalk specialObjectsArray at: 59 set to #conditionalBranchCounterTrippedOn:
	3) have installed the AWFY Json Benchmark (https://github.com/smarr/are-we-fast-yet/tree/master/benchmarks/Smalltalk)"
	| data image input |
	image := '/home/christoph/git/OpenSmalltalk/opensmalltalk-vm/image/spurreader-64-4.1.image'.
	input := (10 timesCollect: ['[1000000 timesRepeat: [(JsonParser with: ''"Carpe Squeak"'') read; readStringInternal]] timeToRunWithoutGC!']) join.
	FileDirectory default fileNamed: 'tmpinput.st' do: [:stream | stream nextPutAll: input].
	data := {'/home/christoph/git/OpenSmalltalk/opensmalltalk-vm/building/linux64x64/squeak.cog.spur/build/squeak'. '/home/christoph/git/OpenSmalltalk/opensmalltalk-vm/building/linux64x64/squeak.sista.spur/build/squeak'} collect: [:vm |
		((FileDirectory default readOnlyFileNamed: 'tmpinput.st' do: [:stream |
			PipeableOSProcess command: vm ,' ' , image input: stream])
			output)
				regex: '(?<=^(squeak> )?)\d+$' matchesCollect: #asNumber].
	((1 to: 10) collect: [:i | i -> (data collect: [:ea | ea at: i])] as: OrderedDictionary) inspect.