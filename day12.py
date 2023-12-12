import re
from itertools import product

def solve(file_name):
    def parse(line):
        a, b = line.split(" ")
        qs = [i for i, x in enumerate(line) if x == "?"]
        return list(a), [int(x) for x in b.split(",")], len(qs), qs

    rows = [parse(x) for x in open(file_name).read().strip().splitlines()]

    result = 0
    for row, arr0, n, qs in rows:
        for prod in product(".#", repeat=n):
            row2 = row.copy()
            for q, p in zip(qs, prod):
                row2[q] = p

            arr1 = [len(x) for x in re.split(r'\.+', "".join(row2)) if len(x)]
            if arr1 == arr0:
                result += 1

    return result

DAY = 12
assert solve(f"inputs/{DAY}e1.txt") == 21
assert solve(f"inputs/{DAY}i.txt") == 7506
