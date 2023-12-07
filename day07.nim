import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

type
    Line = (string, int, int, int)

const cardToBase13 = {'A': 13, 'K': 12, 'Q': 11, 'J': 10, 'T': 9, '9': 8, '8': 7, '7': 6, '6': 5,
                   '5': 4, '4': 3, '3': 2, '2': 1}.toTable()

let handTypes = @[@[5], @[1, 4], @[2, 3], @[1, 1, 3], @[1, 2, 2], @[1, 1, 1, 2], @[1, 1, 1, 1, 1]]

proc parseHand(hand: seq[int]): (int, int) =
    var counts = initTable[int, int]()
    for card in hand:
        let count = hand.countIt(it == card)
        counts[card] = count

    let handTypeIndex = handTypes.find(counts.values.toSeq.sortedByIt(it))
    let strenght = (
        (handTypes.len - handTypeIndex) * (cardToBase13.len ^ (hand.len+1)) +
        countdown(hand.len-1, 0).toSeq.mapIt(cardToBase13.len ^ (hand.len-it) * hand[it]).sum
    )
    
    (handTypeIndex, strenght)

proc parse(file: File): seq[Line] =
    for line in file.lines:
        let xs = line.split(" ")
        let hand = xs[0].mapIt(cardToBase13[it])
        let (handType, strenght) = hand.parseHand
        result.add((xs[0], xs[1].parseInt, strenght, handType))
        
proc part1(file: File): int =
    for i, (hand, bid, strength, handType) in file.parse.sortedByIt(it[2]):
        result += (i + 1) * bid
    
const day = "07"
assert part1(open(fmt"inputs/{day}e1.txt")) == 6440
assert part1(open(fmt"inputs/{day}i.txt")) == 253603890
# echo part2(open(fmt"inputs/{day}e1.txt"))
# echo part2(open(fmt"inputs/{day}i.txt"))
