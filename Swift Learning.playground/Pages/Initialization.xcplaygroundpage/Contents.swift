


//MARK: - Initialization
    //Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.
    //Unlike Objective-C initializers, Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.
    //Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated.



//MARK: - Customizing initialization

//Parameter names and argument labels
    //As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.

struct Celcius {
    var temperatureInCelcius: Double
    
    init(fromFahrenhiet fahrenhiet: Double) {
        temperatureInCelcius = (fahrenhiet - 32) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelcius = kelvin - 273.15
    }
    
    init(_ celcius: Double) {
        temperatureInCelcius = celcius
    }
}

let boilingPointOfWater = Celcius(fromFahrenhiet: 212)
print("Boiling temperature in Celcius: \(boilingPointOfWater.temperatureInCelcius)")  //100.0

let freezingPointOfWater = Celcius(fromKelvin: 273.15)
print("Freezing temperature in Celcius: \(freezingPointOfWater.temperatureInCelcius)")  //0.0

let bodyTemperature = Celcius(37)
print("Body temperature in Celcius: \(bodyTemperature.temperatureInCelcius)")  //37.0


//Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.
//You can assign a value to a constant property at any point during initialization, as long as it’s set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.
//For class instances, a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.

class SurveyQuestion {
    let text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask() //Do you like cheese?

cheeseQuestion.response = "Yes, I like cheese!"





//MARK: - Default initializers
    
//Swift provides a default initializer for any structure or class that provides default values for all of its properties and doesn’t provide at least one initializer itself.
/*
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()
*/


//Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.
//When you call a memberwise initializer, you can omit values for any properties that have default values.

struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2, height: 2)  //width = 2, height = 2

let zeroByTwo = Size(height: 2) //width = 0, height = 2

let zeroByZero = Size() //width = 0, height = 0






//MARK: - Initializer delegation for value types
    //Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.
    //For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.
    //If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() { }  //Same as default initializer
    
    init(origin: Point, size: Size) { //same as memberwise initializer
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)  //initializer delegation
    }
}






//MARK: - Class inheritance and initialization
    //All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
    
//MARK: - Designated Initializers and Convenience Initializers
    //Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
    //Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

    //Initializer Delegation for Class Types
        //Rule 1
            //A designated initializer must call a designated initializer from its immediate superclass.
        //Rule 2
            //A convenience initializer must call another initializer from the same class.
        //Rule 3
            //A convenience initializer must ultimately call a designated initializer.
        
        //A simple way to remember this is:
            //Designated initializers must always delegate up.
            //Convenience initializers must always delegate across.


//MARK: - Two-phase initialization
    //Class initialization in Swift is a two-phase process.
    //In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined,
    //the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.

    //Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:

        //Safety check 1
            //A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
        //Safety check 2
            //A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
        //Safety check 3
            //A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
        //Safety check 4
            //An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

    //Here’s how two-phase initialization plays out, based on the four safety checks above:

        //Phase 1
            // - A designated or convenience initializer is called on a class.
            // - Memory for a new instance of that class is allocated. The memory isn’t yet initialized.
            // - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
            // - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
            // - This continues up the class inheritance chain until the top of the chain is reached.
            // - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
        //Phase 2
            // - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
            // - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.


//Initializer Inheritance and Overriding
    //When you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the override modifier before the subclass’s initializer definition. This is true even if you are overriding an automatically provided default initializer
    //You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.
    //The default initializer (when available) is always a designated initializer for a class
    //If a subclass initializer performs no customization in phase 2 of the initialization process, and the superclass has a zero-argument designated initializer, you can omit a call to super.init() after assigning values to all of the subclass’s stored properties.
    //Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties.

class Vehicle {  //this class has default initializer
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)") //Vehicle: 0 wheel(s)


class Bicycle: Vehicle {
    override init() {  //no stored property for class as its own. so super.init() called first
        super.init()
        numberOfWheels = 2  //changing inherited property after calling superclass designated initializer
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")  //Bicycle: 2 wheel(s)

class Hoverboard: Vehicle {
    let color: String
    init(color: String) {
        self.color = color
        //super.init() implicitely called here because no super class property need not to be change during initialization. no explicit call needed here, swift will handle it.
    }
    
    override var description: String {
        return super.description + " in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "Blue")
print("Hoverboard: \(hoverboard.description)")  //Hoverboard: 0 wheel(s) in a beautiful Blue




//Automatic initializer inheritance
    //subclasses don’t inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met.
    //Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:
        //Rule 1
            //If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
        //Rule 2
            //If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.


//Designated and convenient initializers in action

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let bacon = Food(name: "Bacon")
print(bacon.name)  //Bacon

let mysteryFood = Food()
print(mysteryFood.name) //[Unnamed]


class RecipeIngradient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

    //The init(name: String) convenience initializer provided by RecipeIngredient takes the same parameters as the init(name: String) designated initializer from Food. Because this convenience initializer overrides a designated initializer from its superclass, it must be marked with the override modifier
    //Even though RecipeIngredient provides the init(name: String) initializer as a convenience initializer, RecipeIngredient has nonetheless provided an implementation of all of its superclass’s designated initializers. Therefore, RecipeIngredient automatically inherits all of its superclass’s convenience initializers too.

//we can initialize instance of RecipeIngradient in the following ways
let oneMysterItem = RecipeIngradient() //name: [unnamed] quantity: 1
let oneBacon = RecipeIngradient(name: "Bacon") //name: Bacon quantity: 1
let sixEggs = RecipeIngradient(name: "Egg", quantity: 6) //name: Egg quantity: 6


class ShoppingListItem: RecipeIngradient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔︎" : " ✘"
        return output
    }
}

    //Because it provides a default value for all of the properties it introduces and doesn’t define any initializers itself, ShoppingListItem automatically inherits all of the designated and convenience initializers from its superclass.

var breakFastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Egg", quantity: 6)
]

breakFastList[0].name = "Orange juice"
breakFastList[0].purchased = true

for item in breakFastList {
    print(item.description)
}

    //prints
        // 1 x Orange juice ✔︎
        // 1 x Bacon ✘
        // 6 x Egg ✘




//MARK: - Failable initializers
    //It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
    //You write a failable initializer by placing a question mark after the init keyword (init?)
    //A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.
    //You can’t define a failable and a nonfailable initializer with the same parameter types and names.
    
let wholeNumber = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("The value \(wholeNumber) is maintained as \(valueMaintained)")
}

let valueChanged = Int(exactly: pi) //return as Int? , not Int

if valueChanged == nil {
    print("The value \(pi) cannot be maintained")
}


//custom type example
struct Animal {
    var species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")

if let giraffe = someCreature {
    print("Animale with species name \(giraffe.species) is initialized")
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    print("Animal without species name cannot be initialized")
}
 


//Failable Initializer for enumerations
    //You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters don’t match an appropriate enumeration case.

enum TemperatureUnit {
    case kelvin, celcius, fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celcius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

if let fahrenheitUnit = TemperatureUnit(symbol: "F") {
    print("Initialization succeeded. Temperature is defined in \(fahrenheitUnit) unit") //print fahrenheit
}

let unknownUnit = TemperatureUnit(symbol: "X") //return nil

if unknownUnit == nil {
    print("Initialization faied, Temperature cannot be defined with an unknown symbol")
}


//Failable initializer for enumerations with raw values
    //Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case if one is found, or triggers an initialization failure if no matching value exists.
    //The above example can be rewritten as

enum TempUnit: Character {
    case celcius = "C", kelvin = "K", fahrenheit = "F"
}

if let fahrenheitCase = TempUnit(rawValue: "F") { //true case
    print("Initialization succeeds with temp unit \(fahrenheitCase)")
}

let unknownCase = TempUnit(rawValue: "X") //return nil

if unknownCase == nil {
    print("Initialization failed")
}



//Propagation of Initialization failure
    //A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.
    //In either case, if you delegate to another initializer that causes initialization to fail, the entire initialization process fails immediately, and no further initialization code is executed.
    //A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.

class Product {
    var name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    var quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "Sock", quantity: 2) {
    print("Item: \(twoSocks.name) Quantity: \(twoSocks.quantity)")
}
//prints: Item: Sock Quantity: 2


if let zeroShirts = CartItem(name: "Shirt", quantity: 0) {
    print("Item: \(zeroShirts.name) Quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
//prints: Unable to initialize zero shirts

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name) Quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initilaize one unnamed item")
}
//prints: Unable to initilaize one unnamed item




//Overriding a Failable Initializer
    //You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer. This enables you to define a subclass for which initialization can’t fail, even though initialization of the superclass is allowed to fail.
    //Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.
    //You can override a failable initializer with a nonfailable initializer but not the other way around.

class Document {
    var name: String?
    
    init() { } //initialize with a nil name value
     
    init?(name: String) {   //initialise with a non-empty name value
        if name.isEmpty { return nil }
        self.name = name
    }
}

    //The AutomaticallyNamedDocument subclass overrides both of the designated initializers introduced by Document. These overrides ensure that an AutomaticallyNamedDocument instance has an initial name value of "[Untitled]" if the instance is initialized without a name, or if an empty string is passed to the init(name:) initializer

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        name = "[Unnamed]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Unnamed]"
        } else {
            self.name = name
        }
    }
}

    //You can use forced unwrapping in an initializer to call a failable initializer from the superclass as part of the implementation of a subclass’s nonfailable initializer.

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}


//The init! Failable Initializer
    //you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation point after the init keyword (init!) instead of a question mark.
    //You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.



//MARK: - Required Initializers
    //Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer
    //You must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You don’t write the override modifier when overriding a required designated initializer

class someClass {
    required init() {
        //initializer implementation
    }
}

class someSubClass: someClass {
    required init() {
        //subclass initializer implementation
    }
}



//MARK: - Setting a default property value with a closure or function
    //If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value.
    //at the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
    //If you use a closure to initialize a property, remember that the rest of the instance hasn’t yet been initialized at the point that the closure is executed. This means that you can’t access any other property values from within your closure, even if those properties have default values. You also can’t use the implicit self property, or call any of the instance’s methods.
    
    //skelton
//        class SomeClass {
//            let someProperty: SomeType = {
//                // create a default value for someProperty inside this closure
//                // someValue must be of the same type as SomeType
//                return someValue
//            }()
//        }


struct ChessBoard {
    let board: [Bool] = {
        var temperaryBoard: [Bool] = []
        var isBlack = false
        
        for row in 1...8 {
            for column in 1...8 {
                temperaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        
        return temperaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return board[(row * 8) + column]
    }
}

let board = ChessBoard()

print(board.squareIsBlackAt(row: 0, column: 0)) //false
print(board.squareIsBlackAt(row: 3, column: 2)) //true
print(board.squareIsBlackAt(row: 7, column: 7)) //false

