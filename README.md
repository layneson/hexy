# hexy
Who's going to remember `hexdump -ve '1/1 "%.2x"'`? Why would anyone want to live in a world where they have to remember that?

## Building
Requires `zig` (pre-built grab-and-go found [here](https://ziglang.org/download/)).
```
$ zig build
```
The `hexy` binary can be found in `zig-out/bin`.

## Usage
```
$ hexy tohex <myfile.bin >myfile.hex
$ hexy fromhex <myfile.hex >myfile.bin
```
