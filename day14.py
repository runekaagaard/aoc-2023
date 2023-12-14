from itertools import product

def pp(grid):
    print()
    for row in grid:
        print("".join(row))

def parse(file_name):
    return [list(x) for x in open(file_name).read().strip().splitlines()]

def roll(grid, x, y):
    if grid[y][x] != "O":
        return 0

    y2 = y - 1
    while y2 > -1 and grid[y2][x] == ".":
        grid[y2 + 1][x] = "."
        grid[y2][x] = "O"
        y2 -= 1

    return len(grid) - y2 - 1

def part1(file_name):
    grid = parse(file_name)

    pp(grid)

    result = 0
    for y, x in product(range(len(grid)), range(len(grid[0]))):
        n = roll(grid, x, y)
        result += n

    pp(grid)

    print("result:", result)
    return result

DAY = 14
assert part1(f"inputs/{DAY}e1.txt") == 136
print(part1(f"inputs/{DAY}i.txt"))
