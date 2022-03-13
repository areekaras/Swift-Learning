
//MARK: - Functions
    // Functions are self-contained chunks of code that perform a specific task.
    // You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.
    // Every function in Swift has a type, consisting of the function’s parameter types and return type.
    // You can use this type like any other type in Swift, which makes it easy to pass functions as parameters to other functions, and to return functions from functions.
    // Functions can also be written within other functions to encapsulate useful functionality within a nested function scope.

// Defining and Calling Functions
    // parameters, return type
    // A function’s arguments must always be provided in the same order as the function’s parameter list.
    func greet(person: String) -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }

    print(greet(person: "Anna"))
    // Prints "Hello, Anna!"
    print(greet(person: "Brian"))
    // Prints "Hello, Brian!"

    func greetAgain(person: String) -> String {
        return "Hello again, " + person + "!"
    }
    print(greetAgain(person: "Anna"))
    // Prints "Hello again, Anna!"
    

// Function Parameters and Return Values
    // Functions Without Parameters -> func sayHelloWorld()
    
    // Functions With Multiple Parameters
        func greet(person: String, alreadyGreeted: Bool) -> String {
            if alreadyGreeted {
                return greetAgain(person: person)
            } else {
                return greet(person: person)
            }
        }
        print(greet(person: "Tim", alreadyGreeted: true))
        // Prints "Hello again, Tim!"

    // Functions Without Return Values -> func greet(person: String) { }
        // The return value of a function can be ignored when it’s called:
            func printAndCount(string: String) -> Int {
                print(string)
                return string.count
            }
            func printWithoutCounting(string: String) {
                let _ = printAndCount(string: string)
            }
            printAndCount(string: "hello, world")
            // prints "hello, world" and returns a value of 12
            printWithoutCounting(string: "hello, world")
            // prints "hello, world" but doesn't return a value

    // Functions with Multiple Return Values
        // You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.
        func minMax(array: [Int]) -> (min: Int, max: Int) {
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }

        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        // Prints "min is -6 and max is 109"

    // Optional Tuple Return Types
        func minMaxOpt(array: [Int]) -> (min: Int, max: Int)? {
            if array.isEmpty { return nil }
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }

        if let bounds = minMaxOpt(array: [8, -6, 2, 109, 3, 71]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
        }
        // Prints "min is -6 and max is 109"


    // Functions With an Implicit Return
        // If the entire body of the function is a single expression, the function implicitly returns that expression.
        func greeting(for person: String) -> String {
            "Hello, " + person + "!"
        }
        print(greeting(for: "Dave"))
        // Prints "Hello, Dave!"


// Function Argument Labels and Parameter Names
    // Specifying Argument Labels
        func greet(person: String, from hometown: String) -> String {
            return "Hello \(person)!  Glad you could visit from \(hometown)."
        }
        print(greet(person: "Bill", from: "Cupertino"))
        // Prints "Hello Bill!  Glad you could visit from Cupertino."

    // Omitting Argument Labels
        func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
            // In the function body, firstParameterName and secondParameterName
            // refer to the argument values for the first and second parameters.
        }
        someFunction(1, secondParameterName: 2)

    // Default Parameter Values
        func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
            // If you omit the second argument when calling this function, then
            // the value of parameterWithDefault is 12 inside the function body.
        }
        someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
        someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12

    // Variadic Parameters
        // A variadic parameter accepts zero or more values of a specified type.
        // The values passed to a variadic parameter are made available within the function’s body as an array of the appropriate type.
        func arithmeticMean(_ numbers: Double...) -> Double {
            var total: Double = 0
            for number in numbers {
                total += number
            }
            return total / Double(numbers.count)
        }
        arithmeticMean(1, 2, 3, 4, 5)
        // returns 3.0, which is the arithmetic mean of these five numbers
        arithmeticMean(3, 8.25, 18.75)
        // returns 10.0, which is the arithmetic mean of these three numbers

    // In-Out Parameters
        // Function parameters are constants by default.
        // You can only pass a variable as the argument for an in-out parameter.
        // You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.

        func swapTwoInts(_ first: inout Int, _ second: inout Int) {
            let t = first
            first = second
            second = t
        }

        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        // Prints "someInt is now 107, and anotherInt is now 3"


// Function Types
    // Every function has a specific function type, made up of the parameter types and the return type of the function.
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    // Using Function Types
        var mathFunction: (Int, Int) -> Int = addTwoInts

        print("Result: \(mathFunction(2, 3))")
        // Prints "Result: 5"

        mathFunction = multiplyTwoInts
        print("Result: \(mathFunction(2, 3))")
        // Prints "Result: 6"

        let anotherMathFunction = addTwoInts
        // anotherMathFunction is inferred to be of type (Int, Int) -> Int

    // Function Types as Parameter Types
        func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("Result: \(mathFunction(a, b))")
        }
        printMathResult(addTwoInts, 3, 5)
        // Prints "Result: 8"

    // Function Types as Return Types
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }

        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            return backward ? stepBackward : stepForward
        }

        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        // moveNearerToZero now refers to the stepBackward() function

        print("Counting to zero:")
        // Counting to zero:
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        // 3...
        // 2...
        // 1...
        // zero!


// Nested Functions
    // define functions inside the bodies of other functions, known as nested functions.
    // Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function.
    // An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.
    func chooseStepFunctionNest(backward: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward ? stepBackward : stepForward
    }
    var currentValueNest = -4
    let moveNearerToZeroNest = chooseStepFunctionNest(backward: currentValueNest > 0)
    // moveNearerToZero now refers to the nested stepForward() function
    while currentValueNest != 0 {
        print("\(currentValueNest)... ")
        currentValueNest = moveNearerToZeroNest(currentValueNest)
    }
    print("zero!")
    // -4...
    // -3...
    // -2...
    // -1...
    // zero!
