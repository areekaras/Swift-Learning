
//MARK: - ERROR HANDLING
    //Error handling is the process of responding to and recovering from error conditions in your program.
    //Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.
    //As an example, consider the task of reading and processing data from a file on disk. There are a number of ways this task can fail, including the file not existing at the specified path, the file not having read permissions, or the file not being encoded in a compatible format. Distinguishing among these different situations allows a program to resolve some errors and to communicate to the user any errors it can’t resolve


//MARK:- Representing and throwing errors
    //errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling
    //Swift enumerations are particularly well suited to modeling a group of related error conditions, with associated values allowing for additional information about the nature of an error to be communicated.


enum VendingMachineError: Error {
    case invalidSelection
    case inSufficientFunds(coinsNeeded: Int)
    case outOfStock
}


//MARK:- Handling Errors
    //There are four ways to handle errors in Swift.
        // 1. You can propagate the error from a function to the code that calls that function,
        // 2. Handle the error using a do-catch statement,
        // 3. Handle the error as an optional value.
        // 4. Assert that the error will not occur
    //To identify these places in your code, write the try keyword—or the try? or try! variation—before a piece of code that calls a function, method, or initializer that can throw an error




// 1. Propagating Errors Using Throwing Functions
    //To indicate that a function, method, or initializer can throw an error, you write the throws keyword in the function’s declaration after its parameters.
    //A function marked with throws is called a throwing function.
    //If the function specifies a return type, you write the throws keyword before the return arrow (->)
    //Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Silk": Item(price: 20, count: 5),
        "Snickers": Item(price: 15, count: 4),
        "Galaxy": Item(price: 18, count: 6)
    ]
    
    var coinDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinDeposited else {
            throw VendingMachineError.inSufficientFunds(coinsNeeded: item.price - coinDeposited)
        }
        
        coinDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(inventory[name]!)")
    }
}


    //Because the vend(itemNamed:) method propagates any errors it throws, any code that calls this method must either handle the errors—using a do-catch statement, try?, or try!—or continue to propagate them.
let favouriteSnack = [
    "Shibili": "Silk",
    "Nawaf": "Galaxy",
    "Arshu": "Kinder Joy"
]

func buyFavouriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackBarName = favouriteSnack[person] ?? "Silk"
    try vendingMachine.vend(itemNamed: snackBarName)
}


//Throwing initializers can propagate errors in the same way as throwing functions. For example, the initializer for the PurchasedSnack structure in the listing below calls a throwing function as part of the initialization process, and it handles any errors that it encounters by propagating them to its caller.
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}






// 2. Handling Errors Using Do-Catch
    //You use a do-catch statement to handle errors by running a block of code.
    //If an error is thrown by the code in the do clause, it’s matched against the catch clauses to determine which one of them can handle the error
    /* general form of a do-catch statement
        do {
            try expression
            statements
        } catch pattern 1 {
            statements
        } catch pattern 2 where condition {
            statements
        } catch pattern 3, pattern 4 where condition {
            statements
        } catch {
            statements
        }
    */
    //If a catch clause doesn’t have a pattern, the clause matches any error and binds the error to a local constant named error
    //the propagated error must be handled by some surrounding scope.
    //In a nonthrowing function, an enclosing do-catch statement must handle the error.
    //In a throwing function, either an enclosing do-catch statement or the caller must handle the error.
    //If the error propagates to the top-level scope without being handled, you’ll get a runtime error


let vendingMachine = VendingMachine()
vendingMachine.coinDeposited = 15

do {
    try  buyFavouriteSnack(person: "Shibili", vendingMachine: vendingMachine)
    print("Success, yum!")
} catch VendingMachineError.invalidSelection {
    print("Invalid selection!")
} catch VendingMachineError.outOfStock {
    print("Out of stock")
} catch VendingMachineError.inSufficientFunds(coinsNeeded: let coins) {
    print("Please insert \(coins) more coins")
} catch {
    print("Unexpected error: \(error)")
}
// Prints "Please insert 5 more coins"




func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from vending machine")
    }
}

do {
    try nourish(with: "Kinder joy")
} catch {
    print("Unexpected non-vending-machine-error occured: \(error)")
}
//Prints "Couldn't buy that from vending machine"



    //Another way to catch several related errors is to list them after catch, separated by commas
func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: "Kinder joy")
    } catch VendingMachineError.invalidSelection, VendingMachineError.outOfStock, VendingMachineError.inSufficientFunds {
        print("Invaid selection, Out of stock, or Not enough money.")
    }
}




// 3. Converting Errors to Optional Values
    //You use try? to handle an error by converting it to an optional value.
    //If an error is thrown while evaluating the try? expression, the value of the expression is nil
    //Using try? lets you write concise error handling code when you want to handle all errors in the same way

/*
func someThrowingFunction() throws -> Int {
    // error handling code
}

let x = try? someThrowingFunction()

var y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}


func fetchData() throws -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

*/




// 4. Disabling Error Propagation
    //Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime.
    //On those occasions, you can write try! before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown.
    //If an error actually is thrown, you’ll get a runtime error


    //For example, the following code uses a loadImage(atPath:) function, which loads the image resource at a given path or throws an error if the image can’t be loaded. In this case, because the image is shipped with the application, no error will be thrown at runtime, so it’s appropriate to disable error propagation
//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")







//MARK:- Specifying Cleanup Actions
    //You use a defer statement to execute a set of statements just before code execution leaves the current block of code.
    //This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break.
    //For example, you can use a defer statement to ensure that file descriptors are closed and manually allocated memory is freed
    //A defer statement defers execution until the current scope is exited.
    //This statement consists of the defer keyword and the statements to be executed later.
    //The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error.
    //Deferred actions are executed in the reverse of the order that they’re written in your source code. That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first
    //You can use a defer statement even when no error handling code is involved

/*
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
*/

