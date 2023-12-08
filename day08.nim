import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

proc part1(file: File): int =
    let cmds = file.readLine.toSeq.join(" ").split()
    discard file.readLine

    var graph = initTable[string, seq[string]]()
    for line in file.lines:
        var a, b, c: string
        var ok = scanf(line, "$w = ($w, $w)", a, b, c)
        assert ok and a notin graph
        graph[a] = @[b, c]

    var cur = "AAA"
    for i, cmd in cmds.cycle(100):
        assert cmd in @["L", "R"]
        var j: int = (if cmd == "L": 0 else: 1)
        if cur == "ZZZ":
            return i

        cur = graph[cur][j]

const day = "08"
assert part1(open(fmt"inputs/{day}e1.txt")) == 2
assert part1(open(fmt"inputs/{day}e2.txt")) == 6
assert part1(open(fmt"inputs/{day}i.txt")) == 22357
# assert part2(open(fmt"inputs/{day}e1.txt")) == 5905
# assert part2(open(fmt"inputs/{day}i.txt")) == 253630098
