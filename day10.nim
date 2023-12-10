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

proc nexts(grid: Grid, x: int, y: int): ((int, int), (int, int)) =
    let tile = tileset[grid[y][x]]
    (
        (tile[1][0] + x, tile[1][1] + y), # clockwise.
        (tile[0][0] + x, tile[0][1] + y),
    )
    
proc part12(file: File, s: string): (int, int) =
    var (grid, (x0, y0)) = file.parse(s)

    var
        (xp, yp) = (-1, -1)
        (x, y) = (x0, y0)
        area = 0
        i = 0

    while true:
        let
            ((x1, y1), (x2, y2)) = nexts(grid, x, y)
            (xt, yt) = (x, y)
        
        if ((x1, y1) != (xp, yp)):
            (x, y) = (x1, y1)
        else:
            (x, y) = (x2, y2)
        
        area += xt * (y - yt) # Shoelace formula
        
        if (x, y) == (x0, y0):
            return ((i + 1) div 2, (area - (i+1) div 2 + 1))
            
        (i, xp, yp) = (i+1, xt, yt)

const day = "10"
assert part12(open(fmt"inputs/{day}i.txt"), "7") == (6773, 493)
