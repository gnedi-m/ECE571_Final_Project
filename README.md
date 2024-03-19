# ECE571_Final_Project_Winter2024

This final project includes designing and integrating systems at a high level, creating and utilizing 
SystemVerilog interfaces, implementing bus-functional models using $readmemh, modeling Finite State Machines (FSMs), 
and employing protected SystemVerilog Intellectual Property (IP).

## Description

### Checkpoint0

Form a team and become acquainted with the 8088 processor and its bus protocol and timing. 
This might necessitate additional research. Download the Intel8088 model provided and execute it 
with various bus operations, adjusting the busops.txt file as needed. 
Analyze the resulting waveforms to understand memory and I/O read/write processes and their timing. 
Note that while exact timing isn't crucial, signals should be active at the appropriate clock edges.

### Checkpoint1

Create a synthesizable Finite State Machine (FSM) capable of functioning as a memory or I/O module 
compatible with the 8088 bus. It must include inputs for Chip Select (CS) and Output Enable (OE), 
and ports enabling connection to the 8088 bus. Utilize a subset of 8088 interface pins and interface 
with Address and Data signals, as generated in the provided top-level module by the professor.

### Checkpoint2

Update the main module by incorporating two 512KiB memories, each responding to specific address ranges, 
and two I/O devices, each responsive to designated port ranges. Adjust the busops.txt file to facilitate 
reading from and writing to locations within these devices. Additionally, include a non-synthesizable initial block 
in the module with a filename parameter, enabling the utilization of $readmem to initialize memory contents and I/O register states.

### Checkpoint3

Develop an interface accommodating 8088 pins, distinguishing between Processor and Peripheral operations. Ensure signal names 
align with those observed during instantiation of the provided 8088 model, except for CLK and RESET, which should become 
interface ports. Adapt the given top-level module to instantiate this interface, utilizing it with the Processor modport 
while instantiating the 8088 model provided. This task aims to integrate the provided 8088 module, which incorporates an interface.

## Team Members

- [Nivedita Nadimpalli](nivenadi@pdx.edu): Description of their contribution.
- [Nick Allmeyer](nall2@pdx.edu): Description of their contribution.
- [Mohammed Gnedi](gnedi@pdx.edu): Description of their contribution.

## Tool

QuestaSim 

## Usage

1. Ensure that your SystemVerilog project files, including source code, testbenches, and any necessary scripts or configuration files, 
are organized in a directory structure.
2. In the QuestaSim main window, create a new project/library for the project
3. Compile the SystemVerilog source and testbench files
4. Run the simulation

## Acknowledgments

We would like to express our sincere gratitude to Professor Mark Faust and TA Vinay Patcha for their exceptional support and 
guidance throughout ECE571. Their dedication and assistance have been crucial in our academic journey, enabling us to attain our objectives.
