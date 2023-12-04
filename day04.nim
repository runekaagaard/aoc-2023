import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

proc nums(s: string): HashSet[int] = collect(for x in s.split(" ").filterIt(it.strip.len > 0): {x.parseInt})

iterator parse(file: File): int =
    for line in file.lines:
        yield line.split(":")[1].split("|").mapIt(nums(it)).foldl(a * b).len

proc part1(file: File): int = file.parse.toSeq.filterIt(it > 0).mapIt(2 ^ (it - 1)).sum
    
proc part2(file: File): int =
    var cards = file.parse.toSeq
    var counts = collect(for i in 0 .. cards.len - 1: 1)

    for i in 0 .. cards.len - 1:
        for j in 0 .. cards[i] - 1:
            counts[i+j+1] += counts[i]

    counts.sum

const day = "04"
assert part1(open(fmt"inputs/{day}e1.txt")) == 13
assert part1(open(fmt"inputs/{day}i.txt")) == 33950
assert part2(open(fmt"inputs/{day}e2.txt")) == 30
assert part2(open(fmt"inputs/{day}i.txt")) == 14814534
