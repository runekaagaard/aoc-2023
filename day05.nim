import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

type
    Map = tuple[d, s, r: int]

proc getSeeds(file: File): seq[int] =
    file.read_line.split(": ")[1].split(" ").mapIt(it.strip).map(parseInt)
    
proc initMap(xs: seq): Map = (xs[0], xs[1], xs[2])

proc getCategories(file: File): seq[seq[Map]] =
    collect:
        for category in file.lines.toSeq.filterIt(not it.endsWith(":")).join(".").split(".."):
            category.split(".").filterIt(it.len > 0).mapIt(it.split.mapIt(it.parseInt).initMap)
    
proc distance(seed: int, categories: seq[seq[Map]]): int =
    result = seed
    for i, category in categories:
        for map in category:
            if map.s <= result and result <= map.s + map.r - 1:
                result = result + map.d - map.s
                break

    return result
    
proc part1(file: File): int =
    let (seeds, categories) = (getSeeds(file), getCategories(file))
    seeds.mapIt(it.distance(categories)).min
    
proc part2(file: File): int =
    let (seeds, categories) = (getSeeds(file), getCategories(file))
    
    result = int.high
    for pair in seeds.distribute(seeds.len div 2):
        for seed in pair[0] .. pair[0]+pair[1]-1:
            result = result.min(distance(seed, categories))

const day = "05"
assert part1(open(fmt"inputs/{day}e1.txt")) == 35
assert part1(open(fmt"inputs/{day}i.txt")) == 51752125
assert part2(open(fmt"inputs/{day}e1.txt")) == 46
assert part2(open(fmt"inputs/{day}i.txt")) == 12634632
