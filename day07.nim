import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

type
    Line = (string, int, int, int)

const cardToHex = {'A': 13, 'K': 12, 'Q': 11, 'J': 10, 'T': 9, '9': 8, '8': 7, '7': 6, '6': 5,
                   '5': 4, '4': 3, '3': 2, '2': 1}.toTable()

let handTypes = @[@[5], @[1, 4], @[2, 3], @[1, 1, 3], @[1, 2, 2], @[1, 1, 1, 2], @[1, 1, 1, 1, 1]]

proc handStrength(hand: seq[int]): (int, int) =
    var counts = initTable[int, int]()
    for card in hand:
        let count = hand.countIt(it == card)
        counts[card] = count

    
    let handType = counts.values.toSeq.sortedByIt(it)
    let index = handTypes.find(handType)
    if index == -1:
         echo "missing", handType
    # assert index != -1
    # # echo "    ", handType, " ", handTypes.find(handType), " ", hand
    (index, (6 - index) * 1_000_000_000 + countdown(hand.len-1, 0).toSeq.mapIt(
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
        echo i, " ", (hand, bet, strength), " ", handType, " ", hand.mapIt(cardToHex[it]+1)
        # echo handType, " ", hand.mapIt(cardToHex[it]+1)
        result += (i+1) * bet
    
const day = "07"
echo part1(open(fmt"inputs/{day}e1.txt"))
echo part1(open(fmt"inputs/{day}i.txt")) # 252008590
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
