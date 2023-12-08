import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

proc parse(file: File): (seq[string], Table[string, seq[string]]) =
    let cmds = file.readLine.toSeq.join(" ").split()
    discard file.readLine

    var graph = initTable[string, seq[string]]()
    for line in file.lines:
        var (a, b, c) = (line[0 .. 2], line[7 .. 9], line[12 .. 14])
        assert a notin graph
        graph[a] = @[b, c]

    (cmds, graph)
    
proc part1(file: File, start: string="AAA"): int =
    var (cmds, graph) = parse(file)
    
    var cur = start
    for i, cmd in cmds.cycle(100):
        assert cmd in @["L", "R"]
        var j: int = (if cmd == "L": 0 else: 1)
        if cur.endsWith("Z"):
            return i

        cur = graph[cur][j]
        
proc part2(file_name: string): int =
    var (_, graph) = parse(file_name.open)
    var curs: seq[string]
    for a, _ in graph:
        if a.endsWith("A"):
            curs.add(a)

    var ns: seq[int]
    for cur in curs:
        ns.add(part1(file_name.open, start=cur))

    ns.foldl(lcm(a, b))
        
const day = "08"
assert part1(open(fmt"inputs/{day}e1.txt")) == 2
assert part1(open(fmt"inputs/{day}e2.txt")) == 6
assert part1(open(fmt"inputs/{day}i.txt")) == 22357
assert part2(fmt"inputs/{day}e3.txt") == 6
assert part2(fmt"inputs/{day}i.txt") == 10371555451871
