"""
Wow, I understand how DP works in principle, but it's HARD to construct the solution so it correctly assembles the
correct state/result at the end. This solution is copied from github user fuglede, while trying to groks the
different steps.
"""

def count(inp, arrs, curlen=0, cache=None):
    result = 0
    if cache is None:
        cache = {}

    if (inp, arrs, curlen) in cache:
        return cache[(inp, arrs, curlen)]

    if not inp:
        return 1 if not arrs and not curlen else 0

    if inp[0] == "?":
        nxt = ["#", "."]
    else:
        nxt = inp[0]

    for x in nxt:
        if x == "#":
            result += count(inp[1:], arrs, curlen + 1, cache)  # Continue building arrangement.
        else:
            if curlen > 0:
                if arrs and arrs[0] == curlen:
                    result += count(inp[1:], arrs[1:], 0, cache)  # Close arrangement
            else:
                result += count(inp[1:], arrs, 0, cache)  # No active arrangement, continue.

    cache[inp, arrs, curlen] = result
    return result

def solve(file_name, folds=1):
    def parse(line):
        a, b = line.split(" ")
        return "?".join(a for _ in range(folds)) + ".", eval(b) * folds

    rows = [parse(x) for x in open(file_name).read().strip().splitlines()]

    return sum(count(inp, tuple(arrs)) for inp, arrs in rows)

DAY = 12
assert solve(f"inputs/{DAY}e1.txt") == 21
assert solve(f"inputs/{DAY}i.txt") == 7506
assert solve(f"inputs/{DAY}e1.txt", 5) == 525152
assert solve(f"inputs/{DAY}i.txt", 5) == 548241300348335
