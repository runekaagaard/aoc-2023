from copy import deepcopy

# what
# hfiwegf
# ghrighi

def is_perfect(pattern, lineno):
    d = min(len(pattern) - 1, lineno)

    try:
        for i in range(1, 10000):
            if pattern[lineno - i] != pattern[lineno + i + 1]:
                return False
    except IndexError:
        pass

    return True

def rotate_matrix_clockwise(matrix):
    return [list(x[::-1]) for x in zip(*matrix)]

def reflexions(patterns, multiplier):
    result = 0
    for i, pattern in enumerate(patterns):
        for j in range(len(pattern) - 1):
            # print("".join(pattern[j]))
            if pattern[j] == pattern[j + 1]:
                if is_perfect(pattern, j):
                    result += (j+1) * multiplier
                    break

    return result

def solve(file_name):
    patterns = [[[z for z in y] for y in x.split("\n")] for x in open(file_name).read().split("\n\n")]

    patterns2 = deepcopy(patterns)
    for i in range(len(patterns2)):
        patterns2[i] = rotate_matrix_clockwise(patterns[i])

    result = reflexions(patterns2, 1)
    result += reflexions(patterns, 100)

    return result

DAY = 13

print(solve(f"inputs/{DAY}e1.txt"))
print("B")
print(solve(f"inputs/{DAY}i.txt"))  # 22703 is too low, 30821 is too high
print("C")
print("DONE")
