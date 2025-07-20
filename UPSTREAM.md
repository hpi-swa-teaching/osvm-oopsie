# Upstream Contributions

While most of our work from this master project is contained in this repository, we already contributed several changes to upstream projects.

In the other direction, we have documented other changes that currently live in this repository but should be upstreamed in the future in `VMObjectProxy3 class>>#todoMoveUpstream`.

## [Scorch](https://github.com/clementbera/Scorch/compare/master...MariusDoe:Scorch:squeak)

We ported the core of Scorch from Pharo to Squeak 6.1Alpha, made it compatible with our proxy simulator, and improved support for context simulation.

## Squeak Trunk

### Transparent Proxy Support

- [resolveProxy.3.cs](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/Z7WDON3FBX6YOKRC4SW5NGN4HQXVP73Z/): Proposes a general pattern for resolving transparent proxies in primitive methods.
- [Kernel-ct.1604](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/IYVTB52MU4GGZSMBNA4QVAYZR2TBQXEG/): Fixes Boolean support in ObjectViewer (which currently functions as the de-facto reference implementation of transparent proxies in Squeak).
- [Debugger step unexpected message sends.1.cs](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/J4AUWCVB3CHYUQIPRAS57WLFU44DL5K4/): Fixes stepping over `ifTrue:`/`ifFalse:` sends to Boolean proxies in the debugger.

### Bytecode Representation and Execution

- [Kernel-ct.1599](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/CHOUQNTVPWPGZXJFMNIZYDOSQLXISUOX/): Fixes and revises `CompiledCode` constructors for SistaV1 bytecode set.
- [Kernel-ct.1600](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/YS5G3QTV7OJNLL3RR77JOBC7XCWBLKIF/): Extends support for serializing `CompiledCode`s are `storeString`s.
- [Kernel-ct.1601](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/E7OWV6PK2ELI7VO4QA6G2XKNYBSCMFTT/): Implements and documents the rare bytecode `pushActiveProcess`.
- [Kernel-ct.1605](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/QPXZAHYUT4Q26DHD5TZZ6RDTL7KE3FBZ/): Handles `unusedBytecode` trap from the VM by simulating unknown instructions in the context simulator.
- [Kernel-ct.1606](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/E7DHJTI6KNTJKVDXVK3JGPYBSVETPHOP/): Adds context simulation of `primitiveExitToDebugger`.

### Instruction Printing

- [InstructionPrinter with style.3.cs](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/DDBGAVASGZW7GAYVXUXOQNOPDTBP4QIP/): Adds text styling to all instruction printers in the Trunk and VMMaker.
  
  Depends on:

  - [Collections-ct.1087](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/OGS2WIYUNOL2JJEIPITEP6YF5KXFZTAB/): Adds `Stream>>#isTextStream`.
  - [addAttributesBack.7.cs](https://lists.squeakfoundation.org/archives/list/squeak-dev@lists.squeakfoundation.org/thread/FJUHDHIYGX7YBJ2BP7IZS5FOCMXXSAOE/): Adds reverse-ordered attribute accessors on `Text` and optimizes streaming of formatted texts to a lower complexity class.

## VMMaker

- [VMMaker.oscog-mad.3558](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/thread/IGSL4G7424627NTKWCJX7GZXQS24FIYW/), [VMMaker.oscog-mad.3559](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/message/VHD5223GCGKWVVECHSFPNLJESL6T7CLW/): Fixes for `sendAndBranchData` (`primitiveSistaMethodPICAndCounterData`).
- [VMMaker.oscog-ct.3562](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/thread/YW4FX3PHMQ4CAJXJQLM5LQWXS5PRBSL3/): Adds breakpoint in simulator when encoutering an unknown instruction.
- [VMMaker.oscog-ct.3541](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/thread/AJU5OP6CNJTJETABOD266VNTVUWBPNXR/): Fixes and improves UI layout of `VMMakerTool`.
- [VMMaker.oscog-ct.3556](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/thread/6PPA4WILU6SXNMDBWR6GAXL5IOGN6IGC/), [VMMaker.oscog-mad.3557](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/message/Z65ONKPQGKKLY7JDLSML5CXQJT2EGXGS/), [VMMaker.oscog-ct.3563](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/thread/YTKOAF4AWJXQP3L3COTL2PLZTL55AQN2/), [Simulator-byteCountHelp.1.cs](https://lists.squeakfoundation.org/archives/list/vm-dev@lists.squeakfoundation.org/thread/ZKAE2YD7T6AJQURQ4GNPQ6DTQX7CRMLS/): Miscellaneous minor fixes and documentation improvements.

## OpenSmalltalk VM

- [OpenSmalltalk/opensmalltalk-vm#716](https://github.com/OpenSmalltalk/opensmalltalk-vm/pull/716): Revise installation instructions for Ubuntu
- [OpenSmalltalk/opensmalltalk-vm#719](https://github.com/OpenSmalltalk/opensmalltalk-vm/pull/719): Add support for clang>=16 \[v2\]
- [OpenSmalltalk/opensmalltalk-vm#725](https://github.com/OpenSmalltalk/opensmalltalk-vm/pull/725): Add build files for linux64x64/squeak.sista.spur 
- [OpenSmalltalk/opensmalltalk-vm#728](https://github.com/OpenSmalltalk/opensmalltalk-vm/pull/728): \[ci\] add squeak.sista.spur build for linux64x64 
