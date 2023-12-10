import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

const (north, east, south, west) = ((0, -1), (1, 0), (0, 1), (-1, 0))

type Grid = seq[seq[string]]

let tileset = {"|": (north, south), "-": (east, west), "L": (north, east), "J": (north, west), "7": (south, west),
    "F": (south, east)}.toTable

proc parse(file: File, s: string): (Grid, (int, int)) =
    for i, line in file.lines.toSeq:
        var row: seq[string]
        for j, cha in line:
            var str = fmt"{cha}"
            if str == "S":
                result[1] = (j, i)
                str = s
            row.add(str)

        result[0].add(row)

proc next(grid: Grid, x: int, y: int): ((int, int), (int, int)) =
    let tile = tileset[grid[y][x]]
    (
        (tile[0][0] + x, tile[0][1] + y),
        (tile[1][0] + x, tile[1][1] + y),
    )
    
proc part1(file: File, s: string): int =
    let (grid, (x0, y0)) = file.parse(s)

    var
        (xp, yp) = (-1, -1)
        (x, y) = (x0, y0)

    var i = 0
    while true:
        # echo "-----------------"
        # echo "(xp, yp): ", (xp, yp)
        # echo "(x, y): ", (x, y)

        var ((x1, y1), (x2, y2)) = next(grid, x, y)
        let (xt, yt) = (x, y)
        
        if ((x1, y1) != (xp, yp)):
            (x, y) = (x1, y1)
        elif ((x2, y2) != (xp, yp)):
            (x, y) = (x2, y2)
        else:
            echo "booh: ", ((x1, y1), (x2, y2))
            assert false, "should not happen"

        if (x, y) == (x0, y0):
            return (i + 1) div 2
            
        i += 1
        (xp, yp) = (xt, yt)

const day = "10"

echo part1(open(fmt"inputs/{day}e1.txt"), "F")
echo part1(open(fmt"inputs/{day}e2.txt"), "F")
echo part1(open(fmt"inputs/{day}i.txt"), "7")
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
