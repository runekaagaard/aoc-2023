import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options]

type
  Grid = seq[seq[char]]
  Num = (int, int, int)
  
proc f2grid(file: File): seq =
    ## 0, 0 is top left. Access as [y][x].
    collect:
        for line in file.lines:
            collect:
                for cha in line:
                    cha
                    
proc numAtPoint(grid: seq, x: int, y: int): Option[Num] =
    ## Finds the full number at a point as (x, y, number) or (-1, -1, -1) if not a number.
    var x0 = -1
    
    # Find start of potential number.
    for x2 in countdown(x, 0):
        if grid[y][x2].isDigit:
            x0 = x2
        else:
            break

    if x0 == -1:
        return Num.none
        
    # Find full number
    var digits = ""
    for x2 in countup(x0, grid[0].len-1):
        let cha = grid[y][x2]
        if cha.isDigit:
            digits &= cha
        else:
            break

    return (x0, y, parseInt(digits)).some
        
proc numsAround(grid: Grid, x: int, y: int): HashSet[Num] =
    ## Returns the numbers around a coordinate.
    for dx in countup(-1, 1):
        for dy in countup(-1, 1):
            let num = numAtPoint(grid, x + dx, y + dy)
            if num.isSome:
                result.incl(num.get)
    
iterator symbols(grid: Grid): (int, int) =
    ## Yields coordinates for all the symbols.
    for y, row in grid:
        for x, _ in row:
            let v = grid[y][x]
            if not v.isDigit and v != "."[0]:
                yield (x, y)

proc part1(file: File): int =
    let grid = f2grid(file)
    var nums = initHashSet[Num]()
    for x, y in grid.symbols:
        nums = nums + numsAround(grid, x, y)

    return nums.mapIt(it[2]).sum

proc part2(file: File): int =
    let grid = f2grid(file)
    for x, y in grid.symbols:
        if grid[y][x] != "*"[0]:
            continue

        let numsFound = numsAround(grid, x, y)
        if numsFound.len != 2:
            continue
        
        result += numsFound.mapIt(it[2]).foldl(a * b)

const day = "03"
assert part1(open(fmt"inputs/{day}e1.txt")) == 4361
assert part1(open(fmt"inputs/{day}i.txt")) == 530495
assert part2(open(fmt"inputs/{day}e2.txt")) == 467835
assert part2(open(fmt"inputs/{day}i.txt")) == 80253814
