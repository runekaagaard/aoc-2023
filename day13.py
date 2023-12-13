def pp(pattern):
    print("-----------------------------------------")
    for row in pattern:
        print("".join(row))
    print()

def is_perfect(pattern, lineno):
    for i in range(1, len(pattern)):
        x, y = lineno - i, lineno + i + 1
        if x < 0 or y > (len(pattern) - 1):
            return True

        if pattern[x] != pattern[y]:
            return False

    return True

def rot_clock(matrix):
    return [list(x[::-1]) for x in zip(*matrix)]

def reflexions(patterns, multiplier):
    result = 0
    for i, pattern in enumerate(patterns):
        ok = False
        for j in range(len(pattern) - 1):
            if pattern[j] == pattern[j + 1]:
                if is_perfect(pattern, j):
                    assert ok is False
                    ok = True
                    result += (j+1) * multiplier
                    break

    return result

def solve(file_name):
    patterns = [[[z for z in y] for y in x.split("\n")] for x in open(file_name).read().strip().split("\n\n")]

    result = reflexions([rot_clock(x) for x in patterns], 1)
    result += reflexions(patterns, 100)

    return result

DAY = 13
assert solve(f"inputs/{DAY}e1.txt") == 405
assert solve(f"inputs/{DAY}i.txt") == 28651
