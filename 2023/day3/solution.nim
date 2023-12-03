import options, sequtils, strformat, strutils, tables

const SYMBOLS = {'!'..'-', '/', ':'..'@', '['..'`', '{'..'~'}

proc lineSum(line: string, prevLine: Option[string], nextLine: Option[string]): int =
    var start = 0

    while start < line.len():
        let chr = line[start]
        if chr.isDigit():
            var stop = start
            while stop < line.len() and line[stop].isDigit():
                stop += 1
            stop -= 1
            
            let number = line.substr(start, stop).parseInt()
            if (prevLine.isSome() and prevLine.get().substr(max(0, start - 1), stop + 1).any(proc (chr: char): bool = chr in SYMBOLS)) or
                line[max(0, start - 1)] in SYMBOLS or line[min(stop + 1, line.len() - 1)] in SYMBOLS or
                (nextLine.isSome() and nextLine.get().substr(max(0, start - 1), stop + 1).any(proc (chr: char): bool = chr in SYMBOLS)):
                result += number
            start = stop + 1
        else:
            start += 1


let input = readFile("input.txt").split("\n")

var sum = 0
for i in 0..input.len() - 1:
    sum += lineSum(input[i],
        if i > 0: some(input[i - 1]) else: none(string),
        if i < input.len() - 1: some(input[i + 1]) else: none(string)
    )
echo(&"Part 1: {sum}")

proc findGears(input: seq[string], line: int, numStart: int, numEnd: int): seq[array[2, int]] =
    if line > 1:
        let i = line - 1
        for j in max(0, numStart - 1)..min(numEnd + 1, input[i].len() - 1):
            if input[i][j] == '*':
                result.add([i, j])
    if line < input.len() - 1:
        let i = line + 1
        for j in max(0, numStart - 1)..min(numEnd + 1, input[i].len() - 1):
            if input[i][j] == '*':
                result.add([i, j])
    if numStart > 0 and input[line][numStart - 1] == '*':
        result.add([line, numStart - 1])
    if numEnd < input[line].len() - 1 and input[line][numEnd + 1] == '*':
        result.add([line, numEnd + 1])


proc gearSum(input: seq[string]): int =
    var gearMap = initTable[array[2, int], seq[int]]()
    for i in 0..input.len() - 1:
        let line = input[i]

        var start = 0
        while start < input.len():
            if not line[start].isDigit():
                start += 1
                continue

            var stop = start
            while stop < line.len() and line[stop].isDigit():
                stop += 1
            stop -= 1

            let number = line.substr(start, stop).parseInt()
            for gear in findGears(input, i, start, stop):
                var gearNums = gearMap.getOrDefault(gear, @[])
                gearNums.add(number)
                gearMap[gear] = gearNums
            
            start = stop + 1

    for gear in gearMap.pairs():
        if gear[1].len() == 2:
            result += gear[1][0] * gear[1][1]

sum = gearSum(input)
echo(&"Part 2: {sum}")
