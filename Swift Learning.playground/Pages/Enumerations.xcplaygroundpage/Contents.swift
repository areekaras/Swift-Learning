
//MARK:- ENUMERATIONS
    //An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
    //Enumerations in Swift are first-class types in their own right.
    //They adopt many features traditionally supported only by classes
        // Computed properties to provide additional information about the enumeration’s current value
        // Instance methods to provide functionality related to the values the enumeration represents
        // Initializers to provide an initial case value
        // Can conform to protocols to provide standard functionality.


//MARK:- Enumeration Syntax
    //    enum SomeEnumeration {
    //        // enumeration definition goes here
    //    }

    // Use the case keyword to introduce new enumeration cases.

    
//MARK:- Matching Enumeration Values with a Switch Statement
    // Match individual enumeration values with a switch statement
    


//MARK:- Iterating over Enumeration Cases
    //Use CaseIterable protocol
    //Swift exposes a collection of all the cases as an allCases property of the enumeration type

enum Beverages: CaseIterable {
    case tea, coffee, juice
}

let numberOfBeverages = Beverages.allCases.count
print(numberOfBeverages)

for beverageCase in Beverages.allCases {
    print(beverageCase)
}


//MARK:- Associated Values
    //It’s sometimes useful to be able to store values of other types alongside these case values.
    // This additional information is called an associated value, and
    // it varies each time you use that case as a value in your code.


enum BarCode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarCode = BarCode.upc(5, 43283, 98341, 4)

productBarCode = .qrCode("ABCDFRD")

    //You can check the different barcode types using a switch statement,

switch productBarCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check) ")
case .qrCode(let productCode):
    print("QR Code: \(productCode)")
}

 //If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single var or let annotation before the case name, for brevity

productBarCode = .upc(2, 48957, 89433, 1)

switch productBarCode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check) ")
case let .qrCode(productCode):
    print("QR Code: \(productCode)")
}


//MARK:- Raw Values
    //As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.
    //Raw values can be strings, characters, or any of the integer or floating-point number types.
    //Each raw value must be unique within its enumeration declaration.

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


    //Implicitly Assigned Raw Values
        //When you’re working with enumerations that store integer or string raw values,
        //you don’t have to explicitly assign a raw value for each case.
        //When you don’t, Swift automatically assigns the values for you.

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

    //When strings are used for raw values, the implicit value for each case is the text of that case’s name.
enum CompassPoint: String {
    case north, south, east, west
}

let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"



    //Initializing from a Raw Value
        //If you define an enumeration with a raw-value type,
        //the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil.
        //You can use this initializer to try to create a new instance of the enumeration.
        //the raw value initializer always returns an optional enumeration case.

let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus




//MARK:- Recursive Enumerations
    //A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases.
    //enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

    //You can also write indirect before the beginning of the enumeration
//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

    //(5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))  //Prints "18"



 



