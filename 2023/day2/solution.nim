import strformat, strutils, sequtils

type Pull = object
    red: int
    blue: int
    green: int

proc parsePull(input: string): Pull =
    let colors = input.split(", ")
    var 
        red = 0
        blue = 0
        green = 0
    for color in colors:
        if "red" in color:
            red = parseInt(color.split(" ")[0])
        elif "blue" in color:
            blue = parseInt(color.split(" ")[0])
        elif "green" in color:
            green = parseInt(color.split(" ")[0])

    result = Pull(red: red, blue: blue, green: green)

type Game = object
    id: int
    pulls: seq[Pull]

proc parseGame(input: string): Game =
    let inputParts = input.split(": ")
    let id = inputParts[0].substr(5).parseInt()
    let pulls = inputParts[1].split("; ").map(proc(x: string): Pull = x.parsePull)
    return Game(id: id, pulls: pulls)

proc isSolvable(self: Game): bool =
    for pull in self.pulls:
        if pull.red > 12 or pull.blue > 14 or pull.green > 13:
            return false

    return true

proc power(self: Game): int =
    var 
        red = 0
        blue = 0
        green = 0
    
    for pull in self.pulls:
        red = max(red, pull.red)
        blue = max(blue, pull.blue)
        green = max(green, pull.green)
    
    return red * blue * green



var sum = 0
for line in lines "input.txt":
    let game = line.parseGame()
    if game.isSolvable:
        sum += game.id

echo(&"Part 1: {sum}")

sum = 0
for line in lines "input.txt":
    let game = line.parseGame()
    sum += game.power

echo(&"Part 2: {sum}")