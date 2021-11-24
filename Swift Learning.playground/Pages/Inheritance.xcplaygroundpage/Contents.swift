


//Base class
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) km/h"
    }
    
    func makeNoise() {
        //Do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let someVehicle = Vehicle()
print("Vehicle \(someVehicle.description)") //Vehicle traveling at 0.0 km/h

//subclassing
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 20
print("Bicycle \(bicycle.description)") //Bicycle traveling at 20.0 km/h


//Subclassing from subclass

class Tandem: Bicycle {
    var currentNumberofPassengers = 0
}

let tandem = Tandem()
tandem.currentNumberofPassengers = 2

tandem.hasBasket = true
tandem.currentSpeed = 22
print("Tandom \(tandem.description)") //Tandom traveling at 22.0 km/h



//overriding - methods, properties, subscripts

//Accessing super class
    //method - super.someMethod()
    //property - super.someProperty
    //subscript - super[someIndex]


//method overriding
class Train: Vehicle {
    override func makeNoise() {
        print("Choo choo")
    }
}

let train = Train()
train.makeNoise() //Choo choo

//propery overriding

//Overriding Property Getters and Setters
    //You can provide a custom getter (and setter, if appropriate) to override any inherited property, regardless of whether the inherited property is implemented as a stored or computed property at source. The stored or computed nature of an inherited property isn’t known by a subclass—it only knows that the inherited property has a certain name and type.
    //You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You can’t, however, present an inherited read-write property as a read-only property.
    //If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning super.someProperty from the getter, where someProperty is the name of the property you are overriding.


class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)" //Car traveling at 0.0 km/h in gear 3
    }
}

let car = Car()
car.gear = 3
print("Car \(car.description)")


//property overriding with property observers
    //You can’t add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
    //Note also that you can’t provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.

class AutomatedCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10) + 1
        }
    }
}

let tesla = AutomatedCar()
tesla.currentSpeed = 35
print("Tesla \(tesla.description)")  //Tesla traveling at 35.0 km/h in gear 4


//Preventing overrides
    //You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).
    //You can mark an entire class as final by writing the final modifier before the class keyword in its class definition (final class). Any attempt to subclass a final class is reported as a compile-time error.
