documentation - todo
todo
	"
	* Reconsider UI name 'assembler'
	* Refactor and upstream all my overrides on CodeHolder & Co. (see todoMoveUpstream)
	* Future work: Somehow support do-its with MethodMassage DSL in debugger?
	* Make possible to use with Oopsie:
		* Source code of assembly of method proxies is invalid because literals show with (vm) prefix, thus cannot be recompiled/styled correctly - revise proxy printString or find a way to explicitly hide (but autoresolve) proxies here because users might expect that literals and host method come from same image?
		* Browser on class proxies work very rudimentarily due to performance/identity-full proxies; accept in them does not work at all due to unknown reasons - not a MethodMassage issue, but a general Oopsie problem (?)
	"