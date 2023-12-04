import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

type
    Row = tuple[has, nums: HashSet[int]]

iterator parse(file: File): Row =
    proc makeNums(s: string): HashSet[int] =
        collect(initHashSet()):
            for x in s.split(" "):
                if x.strip.len > 0:
                    {x.parseInt}
                    
    for line in file.lines:
        let parts = line.split(":")[1].split("|")
        yield (makeNums(parts[0]), makeNums(parts[1]))

proc part1(file: File): int =
    file.parse.toSeq.mapIt((it.has * it.nums).len).filterIt(it > 0).mapIt(2 ^ (it - 1)).sum
    
# proc part2(file: File): int =
#     discard

const day = "04"
assert part1(open(fmt"inputs/{day}e1.txt")) == 13
assert part1(open(fmt"inputs/{day}i.txt")) == 33950
# echo part2(open(fmt"inputs/{day}e2.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
