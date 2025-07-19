# OOPSIE: Object-Oriented PointerS Interaction Engine for the OpenSmalltalk-VM Simulator

> Malicious tongues claim it stands for *Object-Oriented PointerS Inspection EnginE* or even *Object-Oriented Pointers inSpection engInE* instead.

OOPSIE is a proxy framework for the [OpenSmalltalk-VM](https://github.com/OpenSmalltalk/opensmalltalk-vm) [simulator](https://dl.acm.org/doi/10.1145/3281287.3281295), designed to facilitate the bootstrapping of [Scorch](https://github.com/clementbera/Scorch)/Sista and interactive exploration and debugging of pointers from a simulated image.

This project was initially developed in the context of a Master's Project @ [hpi-swa-teaching](https://github.com/hpi-swa-teaching) in summer 2025. Many thanks to Marcel Taeumel ([@marceltaeumel](https://github.com/marceltaeumel)) and Eliot Miranda ([@eliotmiranda](https://github.com/eliotmiranda)) for their diligent support and guidance throughout the project!

## Installation

1. Clone the OSVM repo and follow the instructions in their readme to build a VMMaker image and a spurreader image
2. Install [git-s](https://github.com/hpi-swa/git-s)
3. In Git-S, clone and check out this repository

For Scorch, also clone [our fork](https://github.com/MariusDoe/Scorch) and check out the `squeak` branch via Git-S.

## Usage

### Inspection

Start a Sista/Cog VM in the simulator through the Simulation Workspace. Once it is running, send it a do-it like one of these:

```smalltalk
RectangleMorph new tryPrimitive: 114 withArgs: #()!
(Integer>>#benchFib) tryPrimitive: 114 withArgs: #()!
thisContext tryPrimitive: 114 withArgs: #()!
```

In the resulting debugger, do this:

```smalltalk
self inspectOop: self stackTop.
```

Or for the `Context`, even (currently read-only!):

```smalltalk
(self proxyForOop: self stackTop) oopsieUnsimulatedPerform: #debug.
```

And enjoy the freedom of interacting with the simulated object via inspector fields, do-its, nested inspectors/explorers, and more!

|Inspector on a proxy to a `CompiledMethod`, showing all bytecodes and their `sendAndBranchData`.|Debugger on a proxy to a `Context`.|
|-|-|
|![Inspector on a proxy to a `CompiledMethod`, showing all bytecodes and their `sendAndBranchData`.](./screenshots/inspector-method-bytecodes.png)|![Debugger on a proxy to a `Context`.](./screenshots/debugger-context-proxy.png)|

**[I want to see more screenshots!](./screenshots/)**

Alternatively, you can use the *inspect oop...* item from the simulator menu and paste the OOP you want to inspect.

### Running Scorch

Start a Sista VM in the simulator like this:

```smalltalk
| cos |
cos := CogVMSimulator newWithOptions:
	#(Cogit SistaCogit
	SistaVM true
	ObjectMemory Spur64BitCoMemoryManager
	MULTIPLEBYTECODESETS true
	bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid
	ISA X64).
cos desiredNumStackPages: 8.

SoDependencyMap cleanUp. "workaround for identity-full proxies"

cos openOn: 'spurreader-64'.
cos openAsMorph.
[cos run] forkAt: 20
```

When the VM is up, send it the following do-it:

```smalltalk
30 benchFib
```

And step through the breakpoints and cross fingers that it works!

Of course, you may test more complex code, like JSON parsing (`[JsonTests suite debug] benchFor: 0.5 seconds`), but at the current time, you will quickly run into open bugs of Sista/Scorch <sub><sup>(or of our context proxy)</sup></sub>. However, with Oopsie, you will find it easier to debug and fix them than ever before!

## Upstream Changes

This repository also contains a number of rather unrelated changes to the OpenSmalltalk-VM simulator, such as a faster transcript and syntax highlighting for disassembled JIT code. On the other hand, we already contributed back some of our changes to the upstream repositories, many of which are still pending review. You can find a full overview of all of them in [UPSTREAM.md](./UPSTREAM.md).
