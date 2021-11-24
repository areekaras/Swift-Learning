
//MARK: - OPTIONAL CHAINING
    //Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil.
    //If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil.
    //Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

//Optional Chaining as an Alternative to Forced Unwrapping
    //The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.
    //To reflect the fact that optional chaining can be called on a nil value, the result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value.

/*
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomsCount = john.residence!.numberOfRooms //This will trigger a run time error

let roomsCountOpt = john.residence?.numberOfRooms // nil

john.residence = Residence()
if let roomsCount = john.residence?.numberOfRooms {
    print("John residence have \(roomsCount) room(s)") // 1
} else {
    print("Cannot retrieve rooms count")
}


*/



//MARK: - Defining Model Classes for Optional Chaining
    //You can use optional chaining with calls to properties, methods, and subscripts that are more than one level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it’s possible to access properties, methods, and subscripts on those subproperties.

class Person {
    var residence: Residence?
}

class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("number of Rooms: \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingNumber: String?
    var buildingName: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if let buildingNumber = self.buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if let buildingName = buildingName {
            return buildingName
        }
        
        return nil
    }
}





//Accessing Properties Through Optional Chaining

let john = Person()

    //Because john.residence is nil, this optional chaining call fails
if let numberOfRooms = john.residence?.numberOfRooms {
    print("John's residence has \(numberOfRooms) room(s).")
} else {
    print("Not able to retrieve number of rooms")
}
// Prints "Not able to retrieve number of rooms"
    


let someAddress = Address()
someAddress.buildingNumber = "329"
someAddress.street = "Akash nagar"

    //the attempt to set the address property of john.residence will fail, because john.residence is currently nil.
john.residence?.address = someAddress


    //The assignment is part of the optional chaining, which means none of the code on the right-hand side of the = operator is evaluated.
    //The listing below does the same assignment, but it uses a function to create the address. The function prints “Function was called” before returning a value, which lets you see whether the right-hand side of the = operator was evaluated.
    //You can tell that the createAddress() function isn’t called, because nothing is printed.
func createAddress() -> Address {
    print("Create address function called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "329"
    someAddress.street = "Akash nagar"
    
    return someAddress
}

john.residence?.address = createAddress()







//Calling Methods Through Optional Chaining
    //You can use optional chaining to call a method on an optional value, and to check whether that method call is successful.
    //You can do this even if that method doesn’t define a return value.
    
    //If you call this method on an optional value with optional chaining, the method’s return type will be Void?, not Void, because return values are always of an optional type when called through optional chaining.
if john.residence?.printNumberOfRooms() != nil {
    print("Possible to print number of rooms")
} else {
    print("Not possible to print number of rooms")
}
// Prints "Not possible to print number of rooms"







//Accessing Subscripts Through Optional Chaining
    //When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after.
    //The optional chaining question mark always follows immediately after the part of the expression that’s optional.
    
    //Because john.residence is currently nil, the subscript call fails
if let firstRoomName = john.residence?[0].name {
    print("John's first room name is \(firstRoomName)")
} else {
    print("Unable to to retrieve name of the first room")
}
//Prints "Unable to to retrieve name of the first room"

    //This subscript setting attempt also fails, because residence is currently nil.
john.residence?[0] = Room(name: "Office room")


let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Office Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))

john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("John's first room name is \(firstRoomName)")
} else {
    print("Unable to to retrieve name of the first room")
}
//Prints "John's first room name is Office Room"



//Accessing Subscripts of Optional Type
    //If a subscript returns a value of optional type—such as the key subscript of Swift’s Dictionary type—place a question mark after the subscript’s closing bracket to chain on its optional return value
var testScores = ["Dave": [85, 82, 84], "Bev": [90, 94, 81]]
testScores["Dave"]?[0] = 91 //succeeds
testScores["Bev"]?[0] = 80 //succeeds
testScores["Nolan"]?[0] = 50 //fails, because the testScores dictionary doesn’t contain a key for "Nolan"
//the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]






//Linking Multiple Levels of Chaining
    //You can link together multiple levels of optional chaining to drill down to properties, methods, and subscripts deeper within a model. However, multiple levels of optional chaining don’t add more levels of optionality to the returned value.

    //To put it another way:
        // - If the type you are trying to retrieve isn’t optional, it will become optional because of the optional chaining.
        // - If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining.

    //Therefore:

        // - If you try to retrieve an Int value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.
        // - Similarly, if you try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.


    //The value of john.residence currently contains a valid Residence instance. However, the value of john.residence.address is currently nil. Because of this, the call to john.residence?.address?.street fails.
if let streetName = john.residence?.address?.street {
    print("John's street name is \(streetName)")
} else {
    print("Unable to retrieve street name")
}
// Prints "Unable to retrieve street name"


    //the attempt to set the address property of john.residence will succeed, because the value of john.residence currently contains a valid Residence instance.
let johnsAddress = Address()
johnsAddress.buildingName = "The Archade"
johnsAddress.street = "Stockholm"

john.residence?.address = johnsAddress

if let streetName = john.residence?.address?.street {
    print("John's street name is \(streetName)")
} else {
    print("Unable to retrieve street name")
}
// Prints "John's street name is Stockholm"


//Chaining on Methods with Optional Return Values
    
    //This method returns a value of type String?. As described above, the ultimate return type of this method call after optional chaining is also String?
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier)")
}


    //If you want to perform further optional chaining on this method’s return value, place the optional chaining question mark after the method’s parentheses
    //In this example, you place the optional chaining question mark after the parentheses, because the optional value you are chaining on is the buildingIdentifier() method’s return value, and not the buildingIdentifier() method itself
if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}
// Prints "John's building identifier begins with "The"."
