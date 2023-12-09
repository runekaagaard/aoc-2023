import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

proc parse(file: File): seq[seq[int]] =
    collect:
        for line in file.lines:
            collect:
                for n in line.split(" "):
                    n.parseInt
        
proc part12(file: File): (int, int) =
    var result1, result2: int
    for ns in file.parse:
        var
            matrix: seq[seq[int]] = @[ns]
            ns2 = ns

        # Create the matrix
        for i in 0 ..< ns.len-1:
            var ns3: seq[int]
            for j in 0 ..< ns2.len - 1:
                ns3.add(ns2[j+1] - ns2[j])
            
            # Keep an empty line in the bottom for part2
            matrix.add(ns3)
            ns2 = ns3
            if ns3.filterIt(it != 0).len == 0:
                break
            
        # Part1
        result1 += matrix.mapIt(it[it.len-1]).sum

        # Part2
        var n = 0
        for i in countdown(matrix.len-1, 1):
            n = matrix[i-1][0] - n

        result2 += n
    
    (result1, result2)

const day = "09"
assert part12(open(fmt"inputs/{day}e1.txt")) == (114, 2)
