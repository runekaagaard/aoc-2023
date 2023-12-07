import std/[sequtils, strutils, enumerate, strformat, sugar, sets, hashes, math, options, strscans, algorithm, tables]

const joker = 1
const valuesA = {'A': 13, 'K': 12, 'Q': 11, 'J': 10, 'T': 9, '9': 8, '8': 7, '7': 6, '6': 5,
                   '5': 4, '4': 3, '3': 2, '2': 1}.toTable
const valuesB = {'A': 13, 'K': 12, 'Q': 11, 'T': 10, '9': 9, '8': 8, '7': 7, '6': 6,
                   '5': 5, '4': 4, '3': 3, '2': 2, 'J': joker}.toTable

let ranks = @[@[5], @[4], @[2, 3], @[3], @[2, 2], @[2], @[]]

let jokers =[{5: 5}.toTable, {1: 0, 2: 0, 3: 0, 4: 0}.toTable, {1: 1, 2: 0, 3: 0}.toTable,
    {1: 1, 2: 0, 3: 0}.toTable, {1: 2, 2: 1}.toTable, {1: 3, 2: 1, 3: 0}.toTable,
    {1: 5, 2: 3, 3: 1, 4: 0, 5: 0}.toTable,
]

proc ranker(hand: seq[int], values: Table, jokersOn=false, rank: int = -1): (int, int) =
    var counts = initTable[int, int]()
    for card in hand:
        let count = hand.countIt(it == card and (not jokersOn or it != joker))
        if count > 1:
            counts[card] = count

    let rank = (if rank == -1: ranks.find(counts.values.toSeq.sortedByIt(it)) else: rank)
    let strenght = (
        (ranks.len - rank) * (values.len ^ (hand.len+1)) +
        countdown(hand.len-1, 0).toSeq.mapIt(values.len ^ (hand.len-it) * hand[it]).sum
    )
    
    (rank, strenght)
    
proc parse(file: File, values: Table, jokersOn = false): seq[(int, int)] =
    var rank, strenght: int
    for line in file.lines:
        let xs = line.split(" ")
        let hand = xs[0].mapIt(values[it])
        (rank, strenght) = hand.ranker(values, jokersOn)

        if jokersOn:
            var numJokers = hand.filterIt(it == joker).len
            if numJokers > 0:
                (rank, strenght) = hand.ranker(values, jokersOn, jokers[rank][numJokers])
            
        result.add((xs[1].parseInt, strenght))

    result.sortedByIt(it[1])
        
proc part1(file: File): int =
    for i, (bid, strength) in file.parse(valuesA):
        result += (i + 1) * bid
    
proc part2(file: File): int =
    for i, (bid, strength) in file.parse(valuesB, true):
        result += (i + 1) * bid
    
const day = "07"
assert part1(open(fmt"inputs/{day}e1.txt")) == 6440
assert part1(open(fmt"inputs/{day}i.txt")) == 253603890
assert part2(open(fmt"inputs/{day}e1.txt")) == 5905
assert part2(open(fmt"inputs/{day}i.txt")) == 253630098
