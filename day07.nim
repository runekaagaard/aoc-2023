import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

type
    Line = (string, int, int, int)

const cardToBase13A = {'A': 13, 'K': 12, 'Q': 11, 'J': 10, 'T': 9, '9': 8, '8': 7, '7': 6, '6': 5,
                   '5': 4, '4': 3, '3': 2, '2': 1}.toTable

const joker = 1
const cardToBase13B = {'A': 13, 'K': 12, 'Q': 11, 'T': 10, '9': 9, '8': 8, '7': 7, '6': 6,
                   '5': 5, '4': 4, '3': 3, '2': 2, 'J': joker}.toTable

let handTypes = @[@[5], @[4], @[2, 3], @[3], @[2, 2], @[2], @[]]

let powerUp = {
    0: {5: 5}.toTable,
    1: {1: 0, 2: 0, 3: 0, 4: 0}.toTable,
    2: {1: 1, 2: 0, 3: 0}.toTable,
    3: {1: 1, 2: 0, 3: 0}.toTable,
    4: {1: 2, 2: 1}.toTable,
    5: {1: 3, 2: 1, 3: 0}.toTable,
    6: {1: 5, 2: 3, 3: 1, 4: 0, 5: 0}.toTable,
}.toTable

proc parseHand(hand: seq[int], cardToBase13: Table, powerUpHandTypeIndex: int = -1): (int, int) =
    var counts = initTable[int, int]()
    for card in hand:
        let count = hand.countIt(it == card)
        if count > 1:
            counts[card] = count

    var handTypeIndex: int
    if powerUpHandTypeIndex == -1:
        handTypeIndex = handTypes.find(counts.values.toSeq.sortedByIt(it))
        assert handTypeIndex > -1
    else:
        handTypeIndex = powerUpHandTypeIndex
        
    let strenght = (
        # (handTypes.len - handTypeIndex) * (cardToBase13.len ^ (hand.len+1)) +
        (handTypes.len - handTypeIndex) * 100_000_000 +
        countdown(hand.len-1, 0).toSeq.mapIt(cardToBase13.len ^ (hand.len-it) * hand[it]).sum
    )
    
    (handTypeIndex, strenght)

proc parseHand2(hand: seq[int], cardToBase13: Table, powerUpHandTypeIndex: int = -1): (int, int) =
    var counts = initTable[int, int]()
    for card in hand:
        let count = hand.countIt(it == card and it != joker)
        if count > 1:
            counts[card] = count

    var handTypeIndex: int
    if powerUpHandTypeIndex == -1:
        handTypeIndex = handTypes.find(counts.values.toSeq.sortedByIt(it))
        assert handTypeIndex > -1
    else:
        handTypeIndex = powerUpHandTypeIndex
        
    let strenght = (
        # (handTypes.len - handTypeIndex) * (cardToBase13.len ^ (hand.len+1)) +
        (handTypes.len - handTypeIndex) * 100_000_000 +
        countdown(hand.len-1, 0).toSeq.mapIt(cardToBase13.len ^ (hand.len-it) * hand[it]).sum
    )
    
    (handTypeIndex, strenght)
    
proc parse(file: File, cardToBase13: Table): seq[Line] =
    for line in file.lines:
        let xs = line.split(" ")
        let hand = xs[0].mapIt(cardToBase13[it])
        let (handType, strenght) = hand.parseHand(cardToBase13)
        result.add((xs[0], xs[1].parseInt, strenght, handType))

proc parse2(file: File, cardToBase13: Table): seq[Line] =
    var handTypeIndex, strenght: int
    for line in file.lines:
        let xs = line.split(" ")
        let hand = xs[0].mapIt(cardToBase13[it])
        (handTypeIndex, strenght) = hand.parseHand2(cardToBase13)
        
        var numJokers = hand.filterIt(it == joker).len
        if numJokers > 0:
            (handTypeIndex, strenght) = hand.parseHand2(cardToBase13, powerUp[handTypeIndex][numJokers])
            
        result.add((xs[0], xs[1].parseInt, strenght, handTypeIndex))
        
proc part1(file: File): int =
    for i, (hand, bid, strength, handType) in file.parse(cardToBase13A).sortedByIt(it[2]):
        result += (i + 1) * bid
    
proc part2(file: File): int =
    for i, (hand, bid, strength, handType) in file.parse2(cardToBase13B).sortedByIt(it[2]):
        result += (i + 1) * bid
    
const day = "07"
assert part1(open(fmt"inputs/{day}e1.txt")) == 6440
assert part1(open(fmt"inputs/{day}i.txt")) == 253603890
assert part2(open(fmt"inputs/{day}e1.txt")) == 5905
assert part2(open(fmt"inputs/{day}i.txt")) == 253630098
