# hexy
Who's going to remember `hexdump -ve '1/1 "%.2x"'`? Why would anyone want to live in a world where they have to remember that?

## Usage
```
$ hexy tohex <myfile.bin >myfile.hex
$ hexy fromhex <myfile.hex >myfile.bin
```

## Building
Requires `zig` (pre-built grab-and-go found [here](https://ziglang.org/download/)).

### Debug
```
$ zig build
```
The `hexy` binary can be found in `zig-out/bin`.

### Release
```
$ zig build install --prefix <install-prefix> -Doptimize=ReleaseSafe
```
The `hexy` binary can be found in `<install-prefix>/bin`.
