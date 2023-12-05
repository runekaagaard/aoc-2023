import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

type
    Map = tuple[d, s, r: int]

proc asMap(xs: seq): Map =
    (xs[0], xs[1], xs[2])
    
proc parse(file: File): (seq[int], seq[seq[Map]]) =
    let seeds: seq[int] = file.read_line.split(": ")[1].split(" ").mapIt(it.strip).map(parseInt)
    var xs = file.lines.toSeq.filterIt(not it.endsWith(":")).join(".")
    var categories:  seq[seq[Map]]
    
    for category in xs.split(".."):
        var map = category.split(".").filterIt(it.len > 0).mapIt(it.split.mapIt(it.parseInt).asMap)
        categories.add(map)

    return (seeds, categories)
    
proc part1(file: File): int =
    let (seeds, categories) = parse(file)
    var solutions: seq[int]
    
    for seed in seeds:
        var num = seed
        # echo "seed: ", num
        for i, category in categories:
            # echo "  cat: ", i
            for map in category:
                # echo "    map: ", map
                if map.s <= num and num <= map.s + map.r - 1:
                    num = num + map.d - map.s
                    # echo "      new num: ", num
                    break

        solutions.add(num)

    return solutions.min
    
        
    
proc part2(file: File): int =
    discard

const day = "05"
assert part1(open(fmt"inputs/{day}e1.txt")) == 35
assert part1(open(fmt"inputs/{day}i.txt")) == 51752125
# assert part2(open(fmt"inputs/{day}e2.txt")) == 30
# assert part2(open(fmt"inputs/{day}i.txt")) == 14814534
