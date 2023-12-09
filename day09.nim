import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

proc parse(file: File): seq[seq[int]] =
    collect:
        for line in file.lines:
            collect:
                for n in line.split(" "):
                    n.parseInt

proc solve(lines: seq[string]): int =
    discard
        
proc part1(file: File): int =
    for ns in file.parse:
        var matrix: seq[seq[int]] = @[ns]
        
        var ns2 = ns
        for i in 0 ..< ns.len-1:
            var ns3: seq[int]
            for j in 0 ..< ns2.len - 1:
                ns3.add(ns2[j+1] - ns2[j])
            
            if ns3.filterIt(it != 0).len == 0:
                break
            
            matrix.add(ns3)
            ns2 = ns3
        
        # echo "the matrix:"
        # for ns in matrix:
        #     echo "    ", ns

        result += matrix.mapIt(it[it.len-1]).sum
        

const day = "09"
assert part1(open(fmt"inputs/{day}e1.txt")) == 114
assert part1(open(fmt"inputs/{day}i.txt")) = 1834108701
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
