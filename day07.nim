import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm]

type
    Line = (string, int, int)

const cardToHex = {'A': 0xD, 'K': 0xC, 'Q': 0xB, 'J': 0xA, 'T': 0x9, '9': 0x8, '8': 0x7, '7': 0x6, '6': 0x5,
                   '5': 0x4, '4': 0x3, '3': 0x2, '2': 0x1}.toTable()

let handTypes = @[[5].toHashSet, [4].toHashSet, [3, 2].toHashSet, [3].toHashSet, [2, 2].toHashSet,
                    [2].toHashSet, initHashSet[int]()]

proc handStrength(hand: seq[int]): int =
    var handType = initHashSet[int]()
    for card in hand.toHashSet:
        let count = hand.countIt(it == card)
        if count == 1:
            continue
        handType.incl(count)

    (6 - handTypes.find(handType)) * 1_000_000_000 + countdown(hand.len-1, 0).toSeq.mapIt(16^it*hand[it]).sum

proc parse(file: File): seq[Line] =
    for line in file.lines:
        var xs = line.split(" ")
        var hand = xs[0].mapIt(cardToHex[it])
        result.add((xs[0], xs[1].parseInt, hand.handStrength))

proc solve(lines: seq[Line]): int =
    for (hand, bet, strength) in lines.toSeq.sortedByIt(it[2]).reversed:
        echo hand, " ", bet, " ", strength
        
proc part1(file: File): int =
    for i, (hand, bet, strength) in file.parse.sortedByIt(it[2]):
        echo i, " ", (hand, bet, strength)
        result += (i+1) * bet
    
const day = "07"
echo part1(open(fmt"inputs/{day}e1.txt"))
# echo part1(open(fmt"inputs/{day}i.txt"))
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
