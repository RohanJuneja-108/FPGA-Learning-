# FPGA Command Syntax Cheat Sheet

General syntax only, not tied to any project. Replace the names in angle brackets with your own.

## Placeholders

| Placeholder   | Meaning                                         |
|---------------|-------------------------------------------------|
| `<design>`    | Your design file name                           |
| `<tb>`        | Your testbench file name                        |
| `<tb_module>` | The module name inside your testbench           |
| `<TOP>`       | Your top module name                            |
| `<name>`      | Any base name you choose                        |
| `<signal>`    | A port name from your design                    |
| `<pin>`       | A pin number from your board's pinout           |

---

## 1. Create the files (Notepad)

```bash
notepad <design>.v
notepad <tb>.v
notepad io.pcf
```

## 2. Lines that go inside the files

**Inside the testbench, in the `initial` block:**

```verilog
$dumpfile("<name>.vcd");
$dumpvars(0, <tb_module>);
```

**Inside `io.pcf`, one line per port:**

```
set_io <signal> <pin>
```

## 3. Simulate and generate the waveform file

```bash
iverilog -o <name>.vvp <design>.v <tb>.v
vvp <name>.vvp
```

## 4. View the waveform

```bash
gtkwave <name>.vcd
```

## 5. Build for the FPGA

**Yosys**

```bash
yosys -p "read_verilog <design>.v; synth_ice40 -noabc -top <TOP> -json <name>.json"
```

**nextpnr**

```bash
nextpnr-ice40 --up5k --package sg48 --pcf io.pcf --json <name>.json --asc <name>.asc
```

**icepack**

```bash
icepack <name>.asc <name>.bin
```

## 6. Deploy to the board

```bash
iceprog -t
iceprog <name>.bin
```

## 7. Software and Tools Used

| Tool                   | Purpose                                                                                   |
|------------------------|-------------------------------------------------------------------------------------------|
| **OSS CAD Suite**      | Provides the open-source toolchain (Icarus Verilog, GTKWave, Yosys, nextpnr, IceStorm)    |                           |
| **Zadig**              | Installs the USB driver that actually connects the FPGA device to the system              |

**OSS CAD Suite**

- A bundled collection of open-source tools for digital design.
- Used for simulation, waveform viewing, synthesis, place and route, and bitstream generation.



**Zadig**

- Used to install the correct USB driver for the FPGA board.
- Required so the system can detect the FPGA device and so `iceprog` can communicate with it.