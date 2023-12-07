import std/[sequtils, strutils, tables, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm]

type
    Line = (string, int, int, int)

const cardToHex = {'A': 13, 'K': 12, 'Q': 11, 'J': 10, 'T': 9, '9': 8, '8': 7, '7': 6, '6': 5,
                   '5': 4, '4': 3, '3': 2, '2': 1}.toTable()

let handTypes = @[[5].toHashSet, [4].toHashSet, [3, 2].toHashSet, [3].toHashSet, [2, 2].toHashSet,
                    [2].toHashSet, initHashSet[int]()]

echo handTypes.find(@[3, 2].toHashSet)

proc handStrength(hand: seq[int]): (int, int) =
    var handType = initHashSet[int]()
    for card in hand.toHashSet:
        let count = hand.countIt(it == card)
        if count == 1:
            continue
        handType.incl(count)

    # echo "    ", handType, " ", handTypes.find(handType), " ", hand
    (handTypes.find(handType), (6 - handTypes.find(handType)) * 1_000_000_000 + countdown(hand.len-1, 0).toSeq.mapIt(
        16^(hand.len-it)*hand[it]).sum)

proc parse(file: File): seq[Line] =
    for line in file.lines:
        let xs = line.split(" ")
        let hand = xs[0].mapIt(cardToHex[it]+1)
        let (handType, strenght) = hand.handStrength
        # echo line, " ", strenght
        result.add((xs[0], xs[1].parseInt, strenght, handType))
        
proc part1(file: File): int =
    for i, (hand, bet, strength, handType) in file.parse.sortedByIt(it[2]):
        #echo i, " ", (hand, bet, strength), " ", handType, " ", hand.mapIt(cardToHex[it]+1)
        echo handType, " ", hand.mapIt(cardToHex[it]+1)
        result += (i+1) * bet
    
const day = "07"
#echo part1(open(fmt"inputs/{day}e1.txt"))
echo part1(open(fmt"inputs/{day}i.txt")) # 252008590
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
