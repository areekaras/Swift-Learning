
//MARK:- Structures and Classes
    //Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code.
    //You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.
    
//MARK:- Comparing Structures and Classes
    //Both can
        // - Define properties to store values
        // - Define methods to provide functionality
        // - Define subscripts to provide access to their values using subscript syntax
        // - Define initializers to set up their initial state
        // - Be extended to expand their functionality beyond a default implementation
        // - Conform to protocols to provide standard functionality of a certain kind
        
    //Classes have additional capabilities that structures don’t have:
        // - Inheritance enables one class to inherit the characteristics of another.
        // - Type casting enables you to check and interpret the type of a class instance at runtime.
        // - Deinitializers enable an instance of a class to free up any resources it has assigned.
        // - Reference counting allows more than one reference to a class instance.

    //As a general guideline, prefer structures because they’re easier to reason about, and use classes when they’re appropriate or necessary.

    //Definition Syntax
//        struct SomeStructure {
//            // structure definition goes here
//        }
//        class SomeClass {
//            // class definition goes here
//        }


struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

    //Structure and Class Instances
        //The simplest form of initializer syntax uses the type name of the class or structure followed by empty parentheses
        //This creates a new instance of the class or structure, with any properties initialized to their default values.

let someResolution = Resolution()
let someVideoMode = VideoMode()

    //Accessing Properties
        //You can access the properties of an instance using dot syntax.
        //In dot syntax, you write the property name immediately after the instance name, separated by a period (.), without any spaces

print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"

    //You can drill down into subproperties,
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"

    //You can also use dot syntax to assign a new value to a variable property
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"


    //Memberwise Initializers for Structure Types
let vga = Resolution(width: 640, height: 480)





//MARK:- Structures and Enumerations Are Value Types
    //A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.
    //All structures and enumerations are value types in Swift.
    //This means that any structure and enumeration instances you create—and any value types they have as properties—are always copied when they’re passed around in your code.

    //Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying.
    //Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies.
    //If one of the copies of the collection is modified, the elements are copied just before the modification.
    //The behavior you see in your code is always as if a copy took place immediately.

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}

var currentDirection = CompassPoint.east
var rememberedDirection = currentDirection
currentDirection.turnNorth()

print("Current Direction: \(currentDirection)")
print("Remembered Direction: \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"
 




//MARK:- Classes Are Reference Types
    //Unlike value types, reference types are not copied when they’re assigned to a variable or constant, or when they’re passed to a function.
    //Rather than a copy, a reference to the same existing instance is used.


let hd = Resolution(width: 1920, height: 1080)

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("Frame rate -> TenEighty : \(tenEighty.frameRate) -> AlsoTenEighty : \(alsoTenEighty.frameRate)")
// Prints "Frame rate -> TenEighty : 30 -> AlsoTenEighty : 30"


    //Identity Operators === or !==
        //Because classes are reference types, it’s possible for multiple constants and variables to refer to the same single instance of a class behind the scenes.
        // - Identical to (===)
        // - Not identical to (!==)

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer the same VideoMode instance")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."


    //Pointers
        //A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C,
        //but isn’t a direct pointer to an address in memory, and
        //doesn’t require you to write an asterisk (*) to indicate that you are creating a reference.
        //Instead, these references are defined like any other constant or variable in Swift. 
