const std = @import("std");

pub fn main() anyerror!u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = &gpa.allocator;

    const args = (try std.process.argsAlloc(allocator))[1..];
    defer allocator.free(args);

    if (args.len == 0 or
        std.mem.eql(u8, "--help", args[0]) or
        std.mem.eql(u8, "-help", args[0]) or
        std.mem.eql(u8, "-h", args[0]))
    {
        try showHelp();
        return 0;
    }

    if (std.mem.eql(u8, "tohex", args[0])) {
        return try doToHex(args[1..]);
    }

    if (std.mem.eql(u8, "fromhex", args[0])) {
        return try doFromHex(args[1..]);
    }

    try showHelp();
    return 1;
}

fn showHelp() !void {
    const writer = std.io.getStdErr().writer();
    try writer.writeAll("USAGE: hexy {tohex,fromhex}\n");
}

fn doToHex(args: []const []const u8) !u8 {
    _ = args;

    const input_file = std.io.getStdIn();
    const output_file = std.io.getStdOut();

    const reader = input_file.reader();
    const writer = output_file.writer();

    var buffer: [1024]u8 = undefined;
    while (true) {
        const bread = try reader.readAll(&buffer);
        try writer.print("{s}", .{std.fmt.fmtSliceHexLower(buffer[0..bread])});

        if (bread < buffer.len) break;
    }

    return 0;
}

fn doFromHex(args: []const []const u8) !u8 {
    _ = args;

    const input_file = std.io.getStdIn();
    const output_file = std.io.getStdOut();

    const reader = input_file.reader();
    const writer = output_file.writer();

    var buffer: [1024]u8 = undefined;
    while (true) {
        const bread = try reader.readAll(&buffer);
        const bytes = try std.fmt.hexToBytes(&buffer, buffer[0..bread]);
        try writer.writeAll(bytes);

        if (bread < buffer.len) break;
    }

    return 0;
}
