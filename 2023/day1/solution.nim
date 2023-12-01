import strutils, strformat

var sum = 0

for line in lines "input.txt":
    var
        firstDigit = -1
        lastDigit = -1
    
    for chr in line:
        if chr.ord in 48..57:
            if firstDigit == -1:
                firstDigit = parseInt($chr)
            lastDigit = parseInt($chr)
    sum += firstDigit * 10 + lastDigit
echo &"Part 1: {sum}"

sum = 0
for line in lines "input.txt":
    var replacedLine = line.multiReplace(
        ("one", "on1ne"), ("two", "tw2wo"), ("three", "thr3ree"), ("four", "fou4our"),
        ("five", "fiv5ive"), ("six", "si6ix"), ("seven", "seve7even"), ("eight", "eigh8ight"),
        ("nine", "nin9ine"), ("zero", "zer0ero")
    )
    replacedLine = replacedLine.multiReplace(
        ("one", "1"), ("two", "2"), ("three", "3"), ("four", "4"),
        ("five", "5"), ("six", "6"), ("seven", "7"), ("eight", "8"),
        ("nine", "9"), ("zero", "0")
    )
    var
        firstDigit = -1
        lastDigit = -1
    
    for chr in replacedLine:
        if chr.ord in 48..57:
            if firstDigit == -1:
                firstDigit = parseInt($chr)
            lastDigit = parseInt($chr)
    sum += firstDigit * 10 + lastDigit
echo &"Part 2: {sum}"