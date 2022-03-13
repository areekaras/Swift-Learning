
//MARK:- Properties
    //Properties associate values with a particular class, structure, or enumeration.
    //Stored properties store constant and variable values as part of an instance - provided only by classes and structures.
    //computed properties calculate (rather than store) a value - provided by classes, structures, and enumerations


//MARK:- Stored Properties
    //Stored properties can be either variable stored properties (introduced by the var keyword) or constant stored properties (introduced by the let keyword).

    //Stored Properties of Constant Structure Instances
        //If you create an instance of a structure and assign that instance to a constant, you can’t modify the instance’s properties, even if they were declared as variable properties:
        //This behavior is due to structures being value types.
        //The same isn’t true for classes, which are reference types.
        //If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.


    //Lazy stored properties
        //A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used.
        //You indicate a lazy stored property by writing the lazy modifier before its declaration.
        //You must always declare a lazy property as a variable (with the var keyword)
        //Lazy properties are useful when
            //the initial value for a property is dependent on outside factors whose values aren’t known until after an instance’s initialization is complete
            //the initial value for a property requires complex or computationally expensive setup that shouldn’t be performed unless or until it’s needed

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created


print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"

    //If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.





//MARK:- Computed Properties
    //provide a getter and an optional setter to retrieve and set other properties and values indirectly.
    
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center

square.center = Point(x: 15.0, y: 15)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"


    //Shorthand Setter Declaration
        //If a computed property’s setter doesn’t define a name for the new value to be set, a default name of newValue is used
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

    //Shorthand Getter Declaration
        //If the entire body of a getter is a single expression, the getter implicitly returns that expression.
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

    //Read-Only Computed Properties
        //A computed property with a getter but no setter is known as a read-only computed property.
        //A read-only computed property always returns a value, and can be accessed through dot syntax, but can’t be set to a different value.
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"






//MARK:- Property Observers - willSet, didSet
    //Property observers observe and respond to changes in a property’s value.
    //Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
    //You can add property observers in the following places:
        // Stored properties that you define
        // Stored properties that you inherit
        // Computed properties that you inherit

    //You have the option to define either or both of these observers on a property:
         // willSet is called just before the value is stored.
         // didSet is called immediately after the new value is stored.

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

    //If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called.
    //This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function.





//MARK:- Property Wrappers - wrappedValue, projected value
    //A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
    //For example, if you have properties that provide thread-safety checks or store their underlying data in a database, you have to write that code on every property.
    //When you use a property wrapper, you write the management code once when you define the wrapper, and then reuse that management code by applying it to multiple properties.

    //To define a property wrapper, you make a structure, enumeration, or class that defines a wrappedValue property.
 
    //In the code below, the TwelveOrLess structure ensures that the value it wraps always contains a number less than or equal to 12. If you ask it to store a larger number, it stores 12 instead.
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}


struct SmallRectangle {
    @TwelveOrLess var width: Int
    @TwelveOrLess var height: Int
}

var smallRectangle = SmallRectangle()
print("width: \(smallRectangle.width)")

smallRectangle.width = 30
print("width: \(smallRectangle.width)")


//without using the advantage of propertyWrapper attribute, we have to write code like the following
//struct SmallRectangleNoAttribute {
//    private var _width = TwelveOrLess()
//    private var _height = TwelveOrLess()
//
//    var width: Int {
//        get { return _width.wrappedValue }
//        set { _width.wrappedValue = newValue }
//    }
//
//    var height: Int {
//        get { return _height.wrappedValue }
//        set { _height.wrappedValue = newValue }
//    }
//}


//Setting initialValue for Wrappers
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private var maximum: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    init() {
        number = 0
        maximum = 12
    }
    
    init(wrappedValue: Int) {
        number = wrappedValue
        maximum = 12
    }
    
    init(wrappedValue: Int, maximum: Int) {
        number = wrappedValue
        self.maximum = maximum
    }
}


struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

let zeroRect = ZeroRectangle()
print("Zero rectangle width: \(zeroRect.width) height: \(zeroRect.height)")



struct UnitRectangle {
    @SmallNumber var height = 1
    @SmallNumber var width = 1
}

let unitRect = UnitRectangle()
print("Unit rectangle width: \(unitRect.width) height: \(unitRect.height)")



struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var width: Int
    @SmallNumber(wrappedValue: 4, maximum: 4) var height: Int
}

var narrowRect = NarrowRectangle()
print("Narrow rectangle width: \(narrowRect.width) height: \(narrowRect.height)")

narrowRect.width = 100
narrowRect.height = 100

print("Narrow rectangle width: \(narrowRect.width) height: \(narrowRect.height)")



struct MixedRectangle {
    @SmallNumber var width = 5
    @SmallNumber(maximum: 10) var height = 8
}

var mixedRectangle = MixedRectangle()
print("Mixed rectangle width: \(mixedRectangle.width) height: \(mixedRectangle.height)")

mixedRectangle.width = 20
mixedRectangle.height = 50

print("Mixed rectangle width: \(mixedRectangle.width) height: \(mixedRectangle.height)")


 


/*
//Projected value $
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        number = 0
        projectedValue = false
    }
}

struct SomeStructrue {
    @SmallNumber var width: Int
}

var someStructure = SomeStructrue()
someStructure.width = 10
print("value is projected: \(someStructure.$width)") //false

someStructure.width = 13
print("value is projected: \(someStructure.$width)") //true

*/




//Type properties -- static, class
struct SomeStructure {
    static var storedTypeProperty = 0
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = 2
    static var computedStoredProperty: Int {
        return 23
    }
    
    class var canOverriddenComputedTypeProperty: Int {
        return 5
    }
}

class SomeSubClass: SomeClass {
    override class var canOverriddenComputedTypeProperty: Int {
        return 23
    }
}

print(SomeStructure.storedTypeProperty)  //0
SomeStructure.storedTypeProperty = 5
print(SomeStructure.storedTypeProperty) //5

print(SomeEnum.computedTypeProperty) //6

print(SomeClass.computedStoredProperty) //23




struct AudioChannel {
    static let tresholdlevel = 10
    static var maximumLevelOfAllAudioChannel = 0
    
    var currentLevel: Int = 0 {
        didSet {
            if (currentLevel > Self.tresholdlevel) {
                currentLevel = Self.tresholdlevel
            }
            if (currentLevel > Self.maximumLevelOfAllAudioChannel) {
                Self.maximumLevelOfAllAudioChannel = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel) //7
print(AudioChannel.maximumLevelOfAllAudioChannel) //7

rightChannel.currentLevel = 15
print(rightChannel.currentLevel) //10
print(AudioChannel.maximumLevelOfAllAudioChannel) //10
