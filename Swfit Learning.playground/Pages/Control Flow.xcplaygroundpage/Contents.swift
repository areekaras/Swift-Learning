

//Snake ladder game

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;

var square = 0
var diceRoll = 0

gameLoop: while square < finalSquare {
    //roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    
    print("Square before \(square + diceRoll)" , terminator: " ")
    
    switch square + diceRoll {
    case finalSquare:
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        continue gameLoop
    default:
        square += diceRoll
        square += board[square]
    }
    
    print(" after \(square)")
}

print("Game over")




/*
//Switch statement
//fallthrough

let integerToDescribe = 5
var discription = "The number \(integerToDescribe) is "

switch integerToDescribe {
case 2, 3, 5, 7, 11:
    discription += "a prime number "
    fallthrough
default:
    discription += "also an integer"
}

print(discription)
*/
