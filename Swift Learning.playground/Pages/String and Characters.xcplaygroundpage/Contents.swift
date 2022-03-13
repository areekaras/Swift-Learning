
//MARK:- Strings and Characters
    // A string is a series of characters, such as "hello, world" or "albatross".
    // Swift’s String type is bridged with Foundation’s NSString class.
    // Foundation also extends String to expose methods defined by NSString.
    // This means, if you import Foundation, you can access those NSString methods on String without casting.

// String Literals
    // let someString = "Some string literal value"

    // Multiline String Literals
//        let lineBreaks = """
//
//        second line
//        mid
//        secondlast line
//
//        """
//
//        print(lineBreaks)

    // Special Characters in String Literals
        // The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quotation mark) and \' (single quotation mark)
        // An arbitrary Unicode scalar value, written as \u{n}, where n is a 1–8 digit hexadecimal number

    // Extended String Delimiters
//        let threeMoreDoubleQuotationMarks = #"""
//        Here are three more double quotes: """
//        """#
 

// Initializing an Empty String
     var emptyString = ""
     var anotherEmptyString = String()
    // Find out whether a String value is empty by checking its Boolean isEmpty property

// String Mutability
    var variableString = "Horse"
    variableString += " and carriage"
    // variableString is now "Horse and carriage"

//    let constantString = "Highlander"
//    constantString += " and another Highlander"
    // this reports a compile-time error - a constant string cannot be modified

// Strings Are Value Types
    // Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary.
    // This means you always get great performance when working with strings as value types.


// Working with Characters
    for character in "Dog!🐶" {
        print(character)
    }
    // D
    // o
    // g
    // !
    // 🐶

// Concatenating Strings and Characters
    let string1 = "hello"
    let string2 = " there"
    var welcome = string1 + string2
    // welcome now equals "hello there"

    var instruction = "look over"
    instruction += string2
    // instruction now equals "look over there"

    let exclamationMark: Character = "!"
    welcome.append(exclamationMark)
    // welcome now equals "hello there!"

// String Interpolation
    let multiplier = 3
    let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
    // message is "3 times 2.5 is 7.5"

// Unicode
    // Unicode is an international standard for encoding, representing, and processing text in different writing systems.
    // Swift’s String and Character types are fully Unicode-compliant

    // Unicode Scalar Values
        // U+0061 for LATIN SMALL LETTER A ("a"), or U+1F425 for FRONT-FACING BABY CHICK ("🐥").

    // Extended Grapheme Clusters
        // Every instance of Swift’s Character type represents a single extended grapheme cluster.
        // An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character
        let eAcute: Character = "\u{E9}"                         // é
        let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by
        // eAcute is é, combinedEAcute is é

// Counting Characters
    // count property
    let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
    print("unusualMenagerie has \(unusualMenagerie.count) characters")
    // Prints "unusualMenagerie has 40 characters"


    var word = "cafe"
    print("the number of characters in \(word) is \(word.count)")
    // Prints "the number of characters in cafe is 4"

    word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

    print("the number of characters in \(word) is \(word.count)")
    // Prints "the number of characters in café is 4"


// Accessing and Modifying a String
    // You access and modify a string through its methods and properties, or by using subscript syntax.
    
    // String Indices
        // Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string
    let greeting = "Guten Tag!"
    greeting[greeting.startIndex]
    // G
    greeting[greeting.index(before: greeting.endIndex)]
    // !
    greeting[greeting.index(after: greeting.startIndex)]
    // u
    let index = greeting.index(greeting.startIndex, offsetBy: 7)
    greeting[index]
    // a

    greeting[greeting.endIndex] // Error
    greeting.index(after: greeting.endIndex) // Error

    for index in greeting.indices {
        print("\(greeting[index]) ", terminator: "")
    }
    // Prints "G u t e n   T a g ! "


// Inserting and Removing
    // To insert a single character into a string at a specified index, use the insert(_:at:) method,
    // and to insert the contents of another string at a specified index, use the insert(contentsOf:at:) method.
    var welcomeA = "hello"
    welcomeA.insert("!", at: welcomeA.endIndex)
    // welcome now equals "hello!"

    welcomeA.insert(contentsOf: " there", at: welcomeA.index(before: welcomeA.endIndex))
    // welcome now equals "hello there!"

    // To remove a single character from a string at a specified index, use the remove(at:) method,
    // and to remove a substring at a specified range, use the removeSubrange(_:) method.
    welcomeA.remove(at: welcomeA.index(before: welcomeA.endIndex))
    // welcome now equals "hello there"

    let range = welcomeA.index(welcomeA.endIndex, offsetBy: -6)..<welcomeA.endIndex
    welcomeA.removeSubrange(range)
    // welcome now equals "hello"


// Substrings
    // The difference between strings and substrings is that, as a performance optimization,
    // a substring can reuse part of the memory that’s used to store the original string,
    // or part of the memory that’s used to store another substring.
    // This performance optimization means you don’t have to pay the performance cost of copying memory until you modify either the string or substring.
    // Both String and Substring conform to the StringProtocol protocol, which means it’s often convenient for string-manipulation functions to accept a StringProtocol value.
    // You can call such functions with either a String or Substring value.
    let greetingA = "Hello, world!"
    let indexA = greetingA.firstIndex(of: ",") ?? greetingA.endIndex
    let beginning = greetingA[..<indexA]
    // beginning is "Hello"

    // Convert the result to a String for long-term storage.
    let newString = String(beginning)


// Comparing Strings
    // String and Character Equality
        // “equal to” operator (==) and the “not equal to” operator (!=)
        let quotation = "We're a lot alike, you and I."
        let sameQuotation = "We're a lot alike, you and I."
        if quotation == sameQuotation {
            print("These two strings are considered equal")
        }
        // Prints "These two strings are considered equal"

    // Prefix and Suffix Equality
        // hasPrefix(_:) and hasSuffix(_:) methods
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]

        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 ") {
                act1SceneCount += 1
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1")
        // Prints "There are 5 scenes in Act 1"

        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasSuffix("Capulet's mansion") {
                mansionCount += 1
            } else if scene.hasSuffix("Friar Lawrence's cell") {
                cellCount += 1
            }
        }
        print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
        // Prints "6 mansion scenes; 2 cell scenes"



// Unicode Representations of Strings
    // UTF-8 Representation
    // UTF-16 Representation
    // Unicode Scalar Representation

    let dogString = "Dog‼🐶"

    for codeUnit in dogString.utf8 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 226 128 188 240 159 144 182 "

    for codeUnit in dogString.utf16 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 55357 56374 "

    for scalar in dogString.unicodeScalars {
        print("\(scalar.value) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 128054 "

    for scalar in dogString.unicodeScalars {
        print("\(scalar) ")
    }
    // D
    // o
    // g
    // ‼
    // 🐶



