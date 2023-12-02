import sequtils, strutils, tables, std/enumerate


let numberMap = {
  "one": 1, 
  "two": 2, 
  "three": 3, 
  "four": 4, 
  "five": 5, 
  "six": 6, 
  "seven": 7, 
  "eight": 8, 
  "nine": 9,
}.toTable()

proc part12(fp: string, allow_words=false): int =
    var
        file = open(fp)
        sum = 0
    for line in file.lines:
        var (first, last) = (-1, -1)
        for i, c in enumerate(line.toSeq):
            if c.isDigit():
                let n = int(c) - int('0')
                if first == -1:
                    first = n
                last = n
            elif allow_words:
                for k in numberMap.keys():
                    if line.substr(i, line.len-1).startsWith(k):
                        let n = numberMap[k]
                        if first == -1:
                            first = n
                        last = n

        sum += first * 10 + last

    return sum
                
assert part12("inputs/01e1.txt") == 142
assert part12("inputs/01a.txt") == 54951
assert part12("inputs/01e2.txt", true) == 281
assert part12("inputs/01a.txt", true) == 55218

