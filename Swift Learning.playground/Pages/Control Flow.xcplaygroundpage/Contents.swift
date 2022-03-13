
//MARK: - Control Flow
    // Swift provides a variety of control flow statements
    // while loops to perform a task multiple times
    // if, guard, and switch statements to execute different branches of code based on certain conditions
    // break and continue to transfer the flow of execution to another point in your code
    // for-in loop that makes it easy to iterate over arrays, dictionaries, ranges, strings, and other sequences

// For-In Loops
    // for-in loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string.
    let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
    for (animalName, legCount) in numberOfLegs {
        print("\(animalName)s have \(legCount) legs")
    }
    // cats have 4 legs
    // ants have 6 legs
    // spiders have 8 legs

    let minutes = 60
    for tickMark in 0..<minutes {
        // render the tick mark each minute (60 times)
    }

    let minuteInterval = 5
    for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
        // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    }

    let hours = 12
    let hourInterval = 3
    for tickMark in stride(from: 3, through: hours, by: hourInterval) {
        // render the tick mark every 3 hours (3, 6, 9, 12)
    }


// While Loops
    // A while loop performs a set of statements until a condition becomes false.
    // These kinds of loops are best used when the number of iterations isn’t known before the first iteration begins.
    // Swift provides two kinds of while loops:
        // while evaluates its condition at the start of each pass through the loop.
        // repeat-while evaluates its condition at the end of each pass through the loop.


// Conditional Statements
    // If else
    
    // Switch
        // A switch statement considers a value and compares it against several possible matching patterns.
        // It then executes an appropriate block of code, based on the first pattern that matches successfully.
        // No Implicit Fallthrough

        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // Prints "The letter A"

        //Interval Matching
            let approximateCount = 62
            let countedThings = "moons orbiting Saturn"
            let naturalCount: String
            switch approximateCount {
            case 0:
                naturalCount = "no"
            case 1..<5:
                naturalCount = "a few"
            case 5..<12:
                naturalCount = "several"
            case 12..<100:
                naturalCount = "dozens of"
            case 100..<1000:
                naturalCount = "hundreds of"
            default:
                naturalCount = "many"
            }
            print("There are \(naturalCount) \(countedThings).")
            // Prints "There are dozens of moons orbiting Saturn."

        //Tuples
            let somePoint = (1, 1)
            switch somePoint {
            case (0, 0):
                print("\(somePoint) is at the origin")
            case (_, 0):
                print("\(somePoint) is on the x-axis")
            case (0, _):
                print("\(somePoint) is on the y-axis")
            case (-2...2, -2...2):
                print("\(somePoint) is inside the box")
            default:
                print("\(somePoint) is outside of the box")
            }
            // Prints "(1, 1) is inside the box"

        // Value Bindings
            let anotherPoint = (2, 0)
            switch anotherPoint {
            case (let x, 0):
                print("on the x-axis with an x value of \(x)")
            case (0, let y):
                print("on the y-axis with a y value of \(y)")
            case let (x, y):
                print("somewhere else at (\(x), \(y))")
            }
            // Prints "on the x-axis with an x value of 2"

        // Where
            let yetAnotherPoint = (1, -1)
            switch yetAnotherPoint {
            case let (x, y) where x == y:
                print("(\(x), \(y)) is on the line x == y")
            case let (x, y) where x == -y:
                print("(\(x), \(y)) is on the line x == -y")
            case let (x, y):
                print("(\(x), \(y)) is just some arbitrary point")
            }
            // Prints "(1, -1) is on the line x == -y"

        // Compound Cases
            let someCharacter: Character = "e"
            switch someCharacter {
            case "a", "e", "i", "o", "u":
                print("\(someCharacter) is a vowel")
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
                 "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                print("\(someCharacter) is a consonant")
            default:
                print("\(someCharacter) isn't a vowel or a consonant")
            }
            // Prints "e is a vowel"

            let stillAnotherPoint = (9, 0)
            switch stillAnotherPoint {
            case (let distance, 0), (0, let distance):
                print("On an axis, \(distance) from the origin")
            default:
                print("Not on an axis")
            }
            // Prints "On an axis, 9 from the origin"




// Control Transfer Statements
    // Control transfer statements change the order in which your code is executed, by transferring control from one piece of code to another.
    // Swift has five control transfer statements:
        // continue
        // break
        // fallthrough
        // return
        // throw

        // Continue
            // The continue statement tells a loop to stop what it’s doing and start again at the beginning of the next iteration through the loop.
            let puzzleInput = "great minds think alike"
            var puzzleOutput = ""
            let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
            for character in puzzleInput {
                if charactersToRemove.contains(character) {
                    continue
                }
                puzzleOutput.append(character)
            }
            print(puzzleOutput)
            // Prints "grtmndsthnklk"

        // Break
            // The break statement ends execution of an entire control flow statement immediately.
            // Break in a Loop Statement -> ends the loop’s execution immediately
            // Break in a Switch Statement ->
                // causes the switch statement to end its execution immediately and to transfer control to the code after the switch statement’s closing brace (})
                // A switch case that contains only a comment is reported as a compile-time error.
                // Comments aren’t statements and don’t cause a switch case to be ignored.
                // Always use a break statement to ignore a switch case.
            
        // Fallthrough
            // In Swift, switch statements don’t fall through the bottom of each case and into the next one.
            // That is, the entire switch statement completes its execution as soon as the first matching case is completed.
            let integerToDescribe = 5
            var description = "The number \(integerToDescribe) is"
            switch integerToDescribe {
            case 2, 3, 5, 7, 11, 13, 17, 19:
                description += " a prime number, and also"
                fallthrough
            default:
                description += " an integer."
            }
            print(description)
            // Prints "The number 5 is a prime number, and also an integer."

        // Labeled Statements
            // you can mark a loop statement or conditional statement with a statement label.
            // With a conditional statement, you can use a statement label with the break statement to end the execution of the labeled statement.
            // With a loop statement, you can use a statement label with the break or continue statement to end or continue the execution of the labeled statement.
    

    //Snake ladder game

    let finalSquare = 25
    var board = [Int](repeating: 0, count: finalSquare + 1)

    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;

    var square = 0
    var diceRoll = 0

    gameLoop: while square < finalSquare {
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



// Early Exit
    // You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed
    // Unlike an if statement, a guard statement always has an else clause—the code inside the else clause is executed if the condition isn’t true.
    
    func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }

        print("Hello \(name)!")

        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }

        print("I hope the weather is nice in \(location).")
    }

    greet(person: ["name": "John"])
    // Prints "Hello John!"
    // Prints "I hope the weather is nice near you."
    greet(person: ["name": "Jane", "location": "Cupertino"])
    // Prints "Hello Jane!"
    // Prints "I hope the weather is nice in Cupertino."


// Checking API Availability
    if #available(iOS 10, macOS 10.12, *) {
        // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
    } else {
        // Fall back to earlier iOS and macOS APIs
    }

