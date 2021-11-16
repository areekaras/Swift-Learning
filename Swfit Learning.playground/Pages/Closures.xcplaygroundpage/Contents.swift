

//MARK:- Closures
    //Closures are self-contained blocks of functionality that can be passed around and used in your code.
    //Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages
    //Closing over those constants and variables - Closures can capture and store references to any constants and variables from the context in which they’re defined.
    
    //Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:
        // - Global functions are closures that have a name and don’t capture any values.
        // - Nested functions are closures that have a name and can capture values from their enclosing function.
        // - Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

    //Swift’s closure expressions have a clean, clear style, with optimizations which includes:
        // - Inferring parameter and return value types from context
        // - Implicit returns from single-expression closures
        // - Shorthand argument names
        // - Trailing closure syntax




//MARK:- Closure Expressions
    // Closure expressions are a way to write inline closures in a brief, focused syntax.
    
    //Syntax:
//        { (parameters) -> return type in
//            statements
//        }
    
    //The parameters in closure expression syntax can be
        // - in-out parameters, but they can’t have a default value
        // - Variadic parameters can be used if you name the variadic parameter
        // - Tuples

    // in keyword
        // indicates that the definition of the closure’s parameters and return type has finished,
        // and the body of the closure is about to begin.

    //Inferring Type From Context
        //Swift can infer the types of its parameters and the type of the value it returns.
        //Eg:- reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

    //Implicit Returns from Single-Expression Closures
        //Single-expression closures can implicitly return the result of their single expression by omitting the return keyword from their declaration
        //Eg:- reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

    //Shorthand Argument Names
        //Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
        //The in keyword can also be omitted, because the closure expression is made up entirely of its body
        //Eg:- reversedNames = names.sorted(by: { $0 > $1 } )

    //Operator Methods
        //Eg:- reversedNames = names.sorted(by: >)





//MARK:- Trailing Closures
    //If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead.
    //Eg:- reversedNames = names.sorted() { $0 > $1 }
    //If a closure expression is provided as the function’s or method’s only argument and you provide that expression as a trailing closure, you don’t need to write a pair of parentheses () after the function or method’s name when you call the function
    //Eg:- reversedNames = names.sorted { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five",6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [15, 51, 30, 0]

let numbersDigitNames = numbers.map { (number) -> String in
    var number = number
    var output = ""
    
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print(numbersDigitNames)


    //If a function takes multiple closures,
        // - you omit the argument label for the first trailing closure and
        // - you label the remaining trailing closures
    //Eg:-
//        func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
//            if let picture = download("photo.jpg", from: server) {
//                completion(picture)
//            } else {
//                onFailure()
//            }
//        }

    //Calling the function
//        loadPicture(from: someServer) { picture in
//            someView.currentPicture = picture
//        } onFailure: {
//            print("Couldn't download the next picture.")
//        }




//MARK:- Capturing Values
    //A closure can capture constants and variables from the surrounding context in which it’s defined.
    //The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.


func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

    //The incrementer() refers to runningTotal and amount from within its function body.
    //It does this by capturing a reference to runningTotal and amount from the surrounding function and using them within its own function body.
    //Capturing by reference ensures that runningTotal and amount don’t disappear when the call to makeIncrementer ends, and
    //also ensures that runningTotal is available the next time the incrementer function is called.

    //As an optimization, Swift may instead capture and store a copy of a value if that value isn’t mutated by a closure, and if the value isn’t mutated after the closure is created.
    //Swift also handles all memory management involved in disposing of variables when they’re no longer needed.

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen() //10
incrementByTen() //20
incrementByTen() //30

    //If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable
let incrementBySeven = makeIncrementer(forIncrement: 7)

incrementBySeven() //7

incrementByTen() //40

incrementBySeven() //14

    //If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance.
    //Swift uses capture lists to break these strong reference cycles.

 



//MARK:- Closures are Reference Types
    //Functions and closures are reference types.
    //Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure.

    //This also means that if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure.
let alsoIncrementByTen = incrementByTen

alsoIncrementByTen() //50

incrementByTen() //60





//MARK:- Escaping closures
    //A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.
    //Write @escaping before the parameter’s type to indicate that the closure is allowed to escape.

    //One way that a closure can escape is by being stored in a variable that’s defined outside the function.
var completionHandlers: [() -> Void] = []

    //If you didn’t mark the parameter of this function with @escaping, you would get a compile-time error.
func someFunctionWithEscapingClosure(closure: @escaping () -> Void) {
    completionHandlers.append(closure)
}


func someFunctionWithNonEscapingClosure(closure: () -> Void) {
    closure()
}

    //An escaping closure that refers to self needs special consideration if self refers to an instance of a class. Capturing self in an escaping closure makes it easy to accidentally create a strong reference cycle.
class SomeClass {
    var x = 10
    
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonEscapingClosure { x = 200 }
    }
}


var instance = SomeClass()

instance.doSomething()
print(instance.x)   //200

completionHandlers.first?()
print(instance.x)  //100

    //If self is an instance of a structure or an enumeration, you can always refer to self implicitly. However, an escaping closure can’t capture a mutable reference to self when self is an instance of a structure or an enumeration. Structures and enumerations don’t allow shared mutability
struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonEscapingClosure { x = 200 }  // Ok
        someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}





//MARK:- AutoClosures
    //An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function.
    //It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it.
    //This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.

    //An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated.

    //Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.

    //If you want an autoclosure that’s allowed to escape, use both the @autoclosure and @escaping attributes.
 
var customers = ["Arshu", "Nawaf", "Junu", "Abhi", "Nazi"]

var customerProviders: [() -> String] = []

func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customers.remove(at: 0))
collectCustomerProviders(customers.remove(at: 0))

print("Collected \(customerProviders.count) customer providers") // Prints "Collected 2 closures."

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Arshu!"
// Prints "Now serving Nawaf!"
