import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

type
    Map = tuple[d, s, r: int]

proc parse(file: File): (seq[int], seq[seq[Map]]) =
    proc asMap(xs: seq): Map = (xs[0], xs[1], xs[2])
    let seeds: seq[int] = file.read_line.split(": ")[1].split(" ").mapIt(it.strip).map(parseInt)
    var xs = file.lines.toSeq.filterIt(not it.endsWith(":")).join(".")
    var categories:  seq[seq[Map]]
    
    for category in xs.split(".."):
        var map = category.split(".").filterIt(it.len > 0).mapIt(it.split.mapIt(it.parseInt).asMap)
        categories.add(map)

    return (seeds, categories)

proc distance(seed: int, categories: seq[seq[Map]]): int =
    result = seed
    for i, category in categories:
        for map in category:
            if map.s <= result and result <= map.s + map.r - 1:
                result = result + map.d - map.s
                break

    return result
    
proc part1(file: File): int =
    let (seeds, categories) = parse(file)
    seeds.mapIt(it.distance(categories)).min
    
proc part2(file: File): int =
    let (seeds, categories) = parse(file)
    result = int.high
    
    for pair in seeds.distribute(seeds.len div 2):
        for seed in countup(pair[0], pair[0]+pair[1]-1):
            result = result.min(distance(seed, categories))

const day = "05"
assert part1(open(fmt"inputs/{day}e1.txt")) == 35
assert part1(open(fmt"inputs/{day}i.txt")) == 51752125
assert part2(open(fmt"inputs/{day}e1.txt")) == 46
assert part2(open(fmt"inputs/{day}i.txt")) == 12634632
