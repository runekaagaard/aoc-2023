import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options, strscans]

proc nums(line: string): seq[int] = line.split(":")[1].split(" ").filterIt(it.len > 0).mapIt(it.strip.parseInt)
proc parse(lines: seq[string]): seq[(int, int)] = zip(lines[0].nums, lines[1].nums)

proc solve(lines: seq[string]): int =
    lines.parse.map(proc(x: tuple): int = (1 ..< x[0]).toSeq.filterIt((x[0] - it) * it > x[1]).len).prod
        
proc part1(file: File): int = file.lines.toSeq.solve
proc part2(file: File): int = file.lines.toSeq.mapIt(it.replace(" ", "")).solve
    
const day = "06"
assert part1(open(fmt"inputs/{day}e1.txt")) == 288
assert part1(open(fmt"inputs/{day}i.txt")) == 608902
assert part2(open(fmt"inputs/{day}e1.txt")) == 71503
assert part2(open(fmt"inputs/{day}i.txt")) == 46173809
