as yet unclassified
todo
	"This is a prototype! Conceptually we have the following open end:
	* Fix deoptimization of Scorch via Context proxies. We should ensure that Scorch always uses Context class proxies instead of plain Context, but apparently this approach does not yet work. See comment in SoDecompiler>>#recordSunkContext:.
	Once this is fixed, Oopsie should in theory allow us to run the full Scorch optimization/deoptimization cycle through the simulator equivalently to use in production. Several bugs in the Sista VM and Scorch are very much expected at this state of their development, but with the help of the proxies and the simulator, they now should be easier to fix than before.
	
	Other (optional) todos:
	* Fix the proxy for manipulating the active context of the VM (e.g., when running  thisContext tryPrimitive: 114 withArgs: #()  in the VM, doing  (self proxyForOop: self stackTop) oopsieUnsimulatedPerform: #debug  in the debugger, and then trying to step in the second debugger) -- conceptually challenging because the current design of the VM does not intend to do this without sending new messages (maybe we need to use a fake context for this similar like for CogVMSimulator>>#handleTrapInHost:withArgs:?)
	* The example  30 benchFib  works because we set MaxInliningDepth in SoMagicConstants to 2. If we reset it to 10, it fails with another assertion error. Just the next open issue of Sista/Scorch in their current state (probably), or another bug in our proxies (unlikely, but not impossible)?
	* Upstreaming (see todoMoveUpstream)
	* Remove already upstreamed changes from this repo (as of today, VMDeferredFlushTranscriptStream).
	* Update DecoratedAssemblerStyler for upstream changes in decorated disassembly from May-July 2025 (wip)."