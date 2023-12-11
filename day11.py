from itertools import accumulate, combinations

def solve(file_name, spacing):
    rows = list(open(file_name).read().splitlines())
    rng = range(len(rows))
    cols = [[row[i] for row in rows] for i in rng]

    ys = list(accumulate(1 if "#" in y else spacing for y in rows))
    xs = list(accumulate(1 if "#" in y else spacing for y in cols))

    points = [(xs[x], ys[y]) for x in rng for y in rng if rows[y][x] == "#"]

    return sum(abs(x1 - x0) + abs(y1 - y0) for (x0, y0), (x1, y1) in combinations(points, 2))

DAY = 11
assert solve(f"inputs/{DAY}e1.txt", 2) == 374
assert solve(f"inputs/{DAY}i.txt", 2) == 9647174
assert solve(f"inputs/{DAY}e1.txt", 10) == 1030
assert solve(f"inputs/{DAY}e1.txt", 100) == 8410
assert solve(f"inputs/{DAY}i.txt", 1000000) == 377318892554
