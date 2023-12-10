L = open("inputs/10i.txt").read().split("\n")

maze = ['0' * (len(L[0]) + 2)]
for idx, line in enumerate(L[:-1]):
    maze.append('0' + line + '0')
    if "S" in line:
        start = (idx + 1, line.index("S") + 1)
maze.append('0' * (len(L[0]) + 2))

dirchange = {
    'D': {
        'J': 'L',
        '|': 'D',
        'L': 'R'
    },
    'U': {
        '7': 'L',
        '|': 'U',
        'F': 'R'
    },
    'R': {
        'J': 'U',
        '-': 'R',
        '7': 'D'
    },
    'L': {
        'L': 'U',
        '-': 'L',
        'F': 'D'
    }
}
dirincre = {'D': (1, 0), 'U': (-1, 0), 'R': (0, 1), 'L': (0, -1)}

cur = start
count = 1
area = 0
curdir = ''
for direc in dirchange:
    y, x = cur
    dy, dx = dirincre[direc]
    if maze[y + dy][x + dx] in dirchange[direc]:
        curdir = direc

while cur != start or count == 1:
    y, x = cur
    dy, dx = dirincre[curdir]
    area += x * dy  ##This is all that was added for part 2
    print(x, y, dy, area)

    if maze[y + dy][x + dx] == "S" and count > 1:
        break
    cur = (y + dy, x + dx)
    curdir = dirchange[curdir][maze[y + dy][x + dx]]
    count += 1
print("Perimeter  :", count)
print("Part 1     :", count // 2)
print("Total Area :", area + count//2 + 1, count)
print("Part 2     :", area - count//2 + 1)
