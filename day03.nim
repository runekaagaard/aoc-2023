import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes]

type
  Triple = tuple[a, b, c: int]
  Grid = seq[seq[char]]
  
proc f2grid(file: File): seq =
    # 0, 0 is top left. Access as [y][x]
    collect:
        for line in file.lines:
            collect:
                for cha in line:
                    cha

proc numAtPoint(grid: seq, x: int, y: int): Triple =
    var x0 = -1
    # Find start of potential number.
    for x2 in countdown(x, 0):
        if grid[y][x2].isDigit:
            x0 = x2
        else:
            break

    # Find full number
    if x0 != -1:
        var digits = ""
        for x2 in countup(x0, 9999):
            try:
                let cha = grid[y][x2]
                if cha.isDigit:
                    digits.add(cha)
                else:
                    break
            except IndexDefect:
                break

        return (x0, y, parseInt(digits))
    else:
        return (-1, -1, -1)
        
proc numsAround(grid: Grid, x: int, y: int): seq[Triple] =
    for dx in countup(-1, 1):
        for dy in countup(-1, 1):
            try:
                let num = numAtPoint(grid, x + dx, y + dy)
                if num != (-1, -1, -1):
                    if num notin result:
                        result.add(num)
            except IndexDefect:
                discard
    
iterator symbols(grid: Grid): (int, int) =
    for y, row in grid:
        for x, _ in row:
            let v = grid[y][x]
            if not v.isDigit and v != "."[0]:
                yield (x, y)

proc part1(file: File): int =
    let grid = f2grid(file)
    var nums: seq[Triple] = @[]
    for x, y in grid.symbols:
        for num in numsAround(grid, x, y):
            if num notin nums:
                nums.add(num)
                    
    for x in nums:
        result += x[2]
    

const day = "03"
assert part1(open(fmt"inputs/{day}e1.txt")) == 4361
echo "part1 = ", part1(open(fmt"inputs/{day}i.txt"))
# assert part2(fmt"inputs/{day}e1.txt") == 2286
# assert part2(fmt"inputs/{day}i.txt") == 71535
