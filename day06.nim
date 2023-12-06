import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options, strscans]

proc quadratic_nat_range(a: int, b: int): int =
    proc half(x: float): float = x / 2.0
    var (c, d) = (a.float, b.float)
    (c + sqrt(c ^ 2 - 4 * d)).half.ceil.int - (c - sqrt(c ^ 2 - 4 * d)).half.floor.int - 1    
    
proc nums(line: string): seq[int] = line.split(":")[1].split(" ").filterIt(it.len > 0).mapIt(it.strip.parseInt)
proc parse(lines: seq[string]): seq[(int, int)] = zip(lines[0].nums, lines[1].nums)

proc solve(lines: seq[string]): int =
    lines.parse.mapIt(quadratic_nat_range(it[0], it[1])).prod
        
proc part1(file: File): int = file.lines.toSeq.solve
proc part2(file: File): int = file.lines.toSeq.mapIt(it.replace(" ", "")).solve
    
const day = "06"
assert part1(open(fmt"inputs/{day}e1.txt")) == 288
assert part1(open(fmt"inputs/{day}i.txt")) == 608902
assert part2(open(fmt"inputs/{day}e1.txt")) == 71503
assert part2(open(fmt"inputs/{day}i.txt")) == 46173809
