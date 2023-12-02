import std/sequtils, std/strutils, std/tables, std/enumerate, std/strformat

iterator stones(line: string): (int, string) =
    for pair in line.split(":")[1].replace(";", ",").split(","):
        let parts = pair.strip().split(" ")
        yield (parts[0].parseInt, parts[1])

proc part1(fp: string): int =
    let maxAllowed = {"red": 12, "green": 13, "blue": 14}.toTable()
    var file = open(fp)
    
    for i, line in enumerate(file.lines):
        var ok = true
        for n, color in stones(line):
            if n > maxAllowed[color]:
                ok = false

        if ok:
            result += i + 1

    return result

proc part2(fp: string): int =
    var file = open(fp)
    
    for line in file.lines:
        var minRequired = {"red": -1, "green": -1, "blue": -1}.toTable()
        for n, color in stones(line):
            minRequired[color] = max(minRequired[color], n)

        result += minRequired.values.toSeq.foldl(a * b)

    return result

const day = "02"
assert part1(fmt"inputs/{day}e1.txt") == 8
assert part1(fmt"inputs/{day}a.txt") == 2720
assert part2(fmt"inputs/{day}e1.txt") == 2286
assert part2(fmt"inputs/{day}a.txt") == 71535
