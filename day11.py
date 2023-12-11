import itertools

def pp(grid):
    print("\n")
    for x in grid:
        print("".join(x))

def clockwise(grid):
    return [list(row) for row in zip(*grid[::-1])]

def counterclockwise(grid):
    return [list(row) for row in zip(*grid)][::-1]

def parse(file_name):
    return [[y for y in x] for x in open(file_name).read().splitlines()]

def targets(grid):
    targets = []
    for y, row in enumerate(grid):
        for x, value in enumerate(row):
            if value == "#":
                targets.append((x, y))

    return targets

def space(grid):
    grid2 = []
    for row in grid:
        if "#" not in row:
            grid2.append(["."] * len(row))
        grid2.append(row)

    return grid2

def part1(file_name):
    grid = counterclockwise(space(clockwise(space(parse(file_name)))))
    ts = targets(grid)

    result = 0
    for (x0, y0), (x1, y1) in itertools.combinations(ts, 2):
        result += abs(x1 - x0) + abs(y1 - y0)

    return result

DAY = 11
assert part1(f"inputs/{DAY}e1.txt") == 374
assert part1(f"inputs/{DAY}i.txt") == 9647174
