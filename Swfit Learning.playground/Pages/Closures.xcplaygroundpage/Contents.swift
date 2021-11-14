

/*
//Trailing closure

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
*/


/*
//Capturing values

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen() //10
incrementByTen() //20
incrementByTen() //30

let incrementBySeven = makeIncrementer(forIncrement: 7)

incrementBySeven() //7

incrementByTen() //40

incrementBySeven() //14

 
//Closures are reference types

let alsoIncrementByTen = incrementByTen

alsoIncrementByTen() //50

incrementByTen() //60

*/



/*
//Escaping closures

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(closure: @escaping () -> Void) {
    completionHandlers.append(closure)
}

func someFunctionWithNonEscapingClosure(closure: () -> Void) {
    closure()
}

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

*/


/*
//AutoClosures with escaping
 
var customers = ["Arshu", "Nawaf", "Junu", "Abhi", "Nazi"]

var customerProviders: [() -> String] = []

func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customers.remove(at: 0))
collectCustomerProviders(customers.remove(at: 0))

print("Collected \(customerProviders.count) customer providers")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
*/
