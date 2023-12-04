import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

type
    Row = tuple[has, nums: HashSet[int]]

iterator parse(file: File): Row =
    proc makeNums(s: string): HashSet[int] =
        collect:
            for x in s.split(" ").filterIt(it.strip.len > 0): {x.parseInt}
                    
    for line in file.lines:
        let parts = line.split(":")[1].split("|")
        yield (makeNums(parts[0]), makeNums(parts[1]))

proc matches(file: File): seq[int] = file.parse.toSeq.mapIt((it.has * it.nums).len)
proc part1(file: File):   int      = file.matches.filterIt(it > 0).mapIt(2 ^ (it - 1)).sum
    
proc part2(file: File): int =
    var ms = file.matches
    var counts = collect(initTable(ms.len)):
        for i in 0 .. ms.len - 1: {i: 1}

    for i in 0 .. ms.len - 1:
        for j in 0 .. ms[i] - 1:
            counts[i+j+1] += counts[i]

    counts.values.toSeq.sum

const day = "04"
assert part1(open(fmt"inputs/{day}e1.txt")) == 13
assert part1(open(fmt"inputs/{day}i.txt")) == 33950
assert part2(open(fmt"inputs/{day}e2.txt")) == 30
assert part2(open(fmt"inputs/{day}i.txt")) == 14814534
