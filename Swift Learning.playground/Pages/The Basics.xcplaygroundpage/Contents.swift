
/* First multi line comment
 /* Nested comment */
end of multi line comment */



/*
//Integer
print(UInt.min) //0
print(UInt.max) //18446744073709551615

print(Int.min) //-9223372036854775808
print(Int.max)  //9223372036854775808

print(Int8.min) //-128
print(Int8.max) //127

print(Int16.min) //-32768
print(Int32.min) //-2147483648
print(Int64.min) //-9223372036854775808

 */


/*

//implicit unwrap optionals
let assumedString: String! = "dfd"
let implicitString:String = assumedString  //not optional

let optionalString = assumedString //optional
print(optionalString)

 */


/*
//Raw values

//implicit raw values

//enum Planet: Int {
//    case earth, saturn, mercury, pluto
//}
//
//print(Planet.earth.rawValue) //0

enum Planet: Int {
    case earth = 1, saturn, mercury, pluto
}

print(Planet.saturn.rawValue) //2


enum CompassPoint: String {
    case north, east, west, south
}

print(CompassPoint.north.rawValue)


//Initializing from raw value

let possiblePlanet = Planet(rawValue: 4) //Failable initializer, returns optional
print(possiblePlanet ?? "No planet for raw value")

 */


//Recursive enumeration - indirect

//enum ArithmaticExpression {
//    case number(Int)
//    indirect case addition(ArithmaticExpression, ArithmaticExpression)
//    indirect case mulitiplication(ArithmaticExpression, ArithmaticExpression)
//}

//or

indirect enum ArithmaticExpression {
    case number(Int)
    case addition(ArithmaticExpression, ArithmaticExpression)
    case multiplication(ArithmaticExpression, ArithmaticExpression)
}

//Question: evaluate (5 + 4) * 2

let five = ArithmaticExpression.number(5)
let four = ArithmaticExpression.number(4)
let sum = ArithmaticExpression.addition(five, four)
let two = ArithmaticExpression.number(2)
let product = ArithmaticExpression.multiplication(sum, two)


func evaluate(_ expression: ArithmaticExpression) -> Int {
    switch expression {
    case .number(let number):
        return number
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

print("Solution: \(evaluate(product))")



