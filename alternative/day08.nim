#[
REMIND ME IN 20 YEARS
This code should finish at one point, but brute-forcing wasn't it. Disapointing :)
]#

proc part2(file: File): int =
    let cmds = file.readLine.toSeq.join(" ").split()
    discard file.readLine

    var curs: seq[string]
    var graph = initTable[string, seq[string]]()
    for line in file.lines:
        var (a, b, c) = (line[0 .. 2], line[7 .. 9], line[12 .. 14])
        assert a notin graph
        graph[a] = @[b, c]

        if a.endsWith("A"):
            curs.add(a)

    var i = -1
    for _ in 0 .. 1000_000_000_000_000_000_000_000_000_000_000: # waiting for nim bigints or 2048 bit computers
        for cmd in cmds:
            i += 1
            assert cmd in @["L", "R"]
            var j: int = (if cmd == "L": 0 else: 1)
            if curs.allIt(it.endsWith("Z")):
                return i

            for k in 0 ..< curs.len:
                curs[k] = graph[curs[k]][j]
