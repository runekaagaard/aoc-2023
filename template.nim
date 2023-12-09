import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

proc parse(lines: seq[string]): seq[(int, int)] =
    discard

proc solve(lines: seq[string]): int =
    discard
        
proc part1(file: File): int =
    for line in file.lines:
        echo line
    
const day = "07"
echo part1(open(fmt"inputs/{day}e1.txt"))
# echo part1(open(fmt"inputs/{day}i.txt"))
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
