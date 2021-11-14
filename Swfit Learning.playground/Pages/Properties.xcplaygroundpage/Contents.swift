

/*
//Lazy stored properties
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

var manager = DataManager()
manager.data.append("First data")
manager.data.append("Second data")

// the propery of Data manager is not created yet

print(manager.importer.fileName) //Now the importer is created
*/

/*
//Computed properties
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
print("initialSquareCenter x: \(initialSquareCenter.x) y: \(initialSquareCenter.y)")

square.center = Point(x: 15.0, y: 15)
print("Current square origin x: \(square.origin.x) y: \(square.origin.y)")

//Shorthand getter and setter
struct anotherRect {
    var origin: Point
    var size: Size
    
    var center: Point {
        get {  //short hand setter - no 'return' needed if single line
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


//read-only computed property
struct Cuboid {
    var width, height, depth: Double
    
    var volume: Double {
        width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4, height: 5, depth: 2)
print("volume: \(fourByFiveByTwo.volume)")

 */


/*
//Property observers - willSet, didSet
class StepCounter {
    var totalSteps = 0 {
        willSet(newSteps) {
            print("Adding \(newSteps)")
        }
        didSet {
            print("Added \(totalSteps - oldValue) steps")
        }
    }
    
    func changeStepsCount(_ totalSteps: inout Int) {
        //the observers will call again if the property passed as inout parameter
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 100 //Adding 100 //Added 100 steps

stepCounter.totalSteps = 300 //Adding 300 //Added 200 steps

stepCounter.totalSteps = 896 //Adding 896 //Added 596 steps

stepCounter.changeStepsCount(&stepCounter.totalSteps) //Adding 896 //Added 0 steps

 */


//Property wrapper - wrappedValue, projected value

/*
//wrapped value
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


 */


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
