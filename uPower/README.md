# Datapath_MIPS_-_uPowerISA
This repository contains datapath , including the ALU and the Control Unit of the MIPS and uPowerISA.

Any Instruction Set Architecture consists of a Datapath, i.e, a set of stages from input to outut with each stage doing a specific task and passing on the output to the next stage. Datapaths can **pipelined** or **non-pipelined**. Most modern Datapaths are pipelined as it allows a higher instruction execution rate than the non-pipelined version. This implementation is a non-pipelined version of MIPS and IBM's uPower ISA. Both have been designed identically.

The Datapath consists of 5 main stages : 

1. **Instruction Fetch** : This stage accesses instruction memory and fetches the instruction at an address stored in the **CIA(Current Instruction Address)** register. In our implementation we consider the program counter itself as the current instruction address as we read from a in-memory set of instructions. The **Read_Instructions.v** file performs this action.

2. **Instruction Decode** : This takes takes in the input 32-bit binary instruction and decodes according to the uPower ISA manual. Depending on the type of instruction, it is split into an opcode, 2 or 3 register addresses(To decide which register to read from or write in), 1 or 2 flags, immediate values, etc.
This is performed in **Instr_parse.v** where an instruction is broken down into it's components. Between this and the next stage, the Control Unit takes into account these changes and assigns flags such as Register Read/Write(Whether the register is to be written into or read from), Memory Read/Write(Whether a data memory access is required), Program Counter Jump(Whether the instruction requires a branch to another instruction), Write back(Only for load instructions), etc. This working is implemented in **Control_Unit.v**.

3. **ALU** : The Instruction decode stage passes along information regarding which registers to read from and the corresponding registers are read and their data is fed into the ALU. Depending on the instruction opcode, and an ALU operation signal provided by the Control Unit, the ALU performs the operation. All load and store instructions require an **immediate value(offset)** to be added to the address stored in a register, whose value is given in the instruction and passed on to the ALU by the Instruction decode stage. If it is a normal arithmetic instruction, the output data is written into the write register, again, pointed to in the instruction. This is implemented in the **ALU64Bit.v** file.

4. **Memory Access** : While the first stage involved access to the instruction memory, this time, the data memory is accessed. This stage is only performed for **Loads and Stores**, i.e, when Data has to be loaded from Main memory into the registers, or data from registers have to be written back into memory. This stage takes up the most time in any Datapath and hence loads and stores are the most common instructions to be reordered by optimization softwares. This is performed by **Read_Memory.v**.

5. **Write Back** : This stage is only performed for Stores, when the data read by the memory access stage has to be written back into the register. This is performed by reading a signal called **MemToReg**, given by the Control Unit.

The 5 modules have been implemented for both ISA's. They are initialized in the **uPower_Core.v** file which also takes care of updating the program counter appropriately depending on whether or not the instruction calls for a jump. The **uPower_tb.v** runs the clock for the core file.
