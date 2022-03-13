
//MARK: - Collection Types
    // Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values.
    // Arrays are ordered collections of values.
    // Sets are unordered collections of unique values.
    // Dictionaries are unordered collections of key-value associations.
    // Swift’s array, set, and dictionary types are implemented as generic collections.

//Mutability of Collections
    // var and let
    // It’s good practice to create immutable collections in all cases where the collection doesn’t need to change.
    // Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.

//MARK: - ARRAYS
    // An array stores values of the same type in an ordered list.
    // The same value can appear in an array multiple times at different positions.
    // Swift’s Array type is bridged to Foundation’s NSArray class.

    // Array Type Shorthand Syntax
        // full as Array<Element>
        // shorthand form as [Element]

    // Creating an Empty Array -> var someInts: [Int] = []
    // Creating an Array with a Default Value -> var threeDoubles = Array(repeating: 0.0, count: 3)
    
    // Creating an Array by Adding Two Arrays Together
        // var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
            // anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

        // var sixDoubles = threeDoubles + anotherThreeDoubles
            // sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

    // Creating an Array with an Array Literal
        // var shoppingList: [String] = ["Eggs", "Milk"]
        // var shoppingList = ["Eggs", "Milk"]

    // Accessing and Modifying an Array
        // read-only count property
        // isEmpty property
        // append(_:) method
        // addition assignment operator (+=)
        // subscript syntax
            // var firstItem = shoppingList[0]
            // shoppingList[0] = "Six eggs"
            // shoppingList[4...6] = ["Bananas", "Apples"]
        // insert(_:at:) method -> shoppingList.insert("Maple Syrup", at: 0)
        // remove(at:) method -> let mapleSyrup = shoppingList.remove(at: 0)

        // If you try to access or modify a value for an index that’s outside of an array’s existing bounds, you will trigger a runtime error.
    
        
    // Iterating Over an Array
        // for-in loop
        // If you need the integer index of each item as well as its value, use the enumerated() method to iterate over the array instead.
            // for (index, value) in shoppingList.enumerated() { }



//MARK: - SETS
    // A set stores distinct values of the same type in a collection with no defined ordering.
    // You can use a set instead of an array when the order of items isn’t important,
    // or when you need to ensure that an item only appears once.
    // Swift’s Set type is bridged to Foundation’s NSSet class.

    // Hash Values for Set Types
        // A type must be hashable in order to be stored in a set
        // All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default
        // Enumeration case values without associated values are also hashable by default.
        // You can use your own custom types as set value types or dictionary key types by making them conform to the Hashable protocol from the Swift standard library.

    // Set Type Syntax -> Set<Element>
    // Creating and Initializing an Empty Set
        var letters = Set<Character>() // or letters = []
    
    // Creating a Set with an Array Literal
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // or var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]

    // Accessing and Modifying a Set
        // read-only count property
        // isEmpty property
        // insert(_:) method
            favoriteGenres.insert("Jazz")
        // remove(_:) method
            if let removedGenre = favoriteGenres.remove("Rock") {
                print("\(removedGenre)? I'm over it.")
            } else {
                print("I never much cared for that.")
            }
            // Prints "Rock? I'm over it."

        // contains(_:) method
            if favoriteGenres.contains("Funk") {
                print("I get up on the good foot.")
            } else {
                print("It's too funky in here.")
            }
            // Prints "It's too funky in here."

        // Iterating Over a Set
            for genre in favoriteGenres {
                print("\(genre)")
            }
            // Classical
            // Jazz
            // Hip hop

        // sorted() method
            for genre in favoriteGenres.sorted() {
                print("\(genre)")
            }
            // Classical
            // Hip hop
            // Jazz


    // Performing Set Operations
        // intersection(_:) method to create a new set with only the values common to both sets.
        // symmetricDifference(_:) method to create a new set with values in either set, but not both.
        // union(_:) method to create a new set with all of the values in both sets.
        // subtracting(_:) method to create a new set with values not in the specified set.
        
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]

    // Set Membership and Equality
        // “is equal” operator (==) to determine whether two sets contain all of the same values.
        // isSubset(of:) method to determine whether all of the values of a set are contained in the specified set.
        // isSuperset(of:) method to determine whether a set contains all of the values in a specified set.
        // isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
        // isDisjoint(with:) method to determine whether two sets have no values in common.

        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]

        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true



//MARK: - DICTIONARIES
    // A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering.
    // Each value is associated with a unique key, which acts as an identifier for that value within the dictionary.
    // You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.
    // Swift’s Dictionary type is bridged to Foundation’s NSDictionary class.

    // Dictionary Type Shorthand Syntax
        // full as Dictionary<Key, Value>
        // shorthand form as [Key: Value]
    
    // A dictionary Key type must conform to the Hashable protocol, like a set’s value type.

    // Creating an Empty Dictionary
        var namesOfIntegers: [Int: String] = [:]
        // namesOfIntegers is an empty [Int: String] dictionary

        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers now contains 1 key-value pair
        namesOfIntegers = [:]
        // namesOfIntegers is once again an empty dictionary of type [Int: String]
    
    // Creating a Dictionary with a Dictionary Literal
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        //or var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

    // Accessing and Modifying a Dictionary
        // read-only count property
        // isEmpty property
        // subscript syntax
            airports["LHR"] = "London"
            // the airports dictionary now contains 3 items

            airports["LHR"] = "London Heathrow"
            // the value for "LHR" has been changed to "London Heathrow"
        
        // updateValue(_:forKey:) method
            if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
                print("The old value for DUB was \(oldValue).")
            }
            // Prints "The old value for DUB was Dublin."

            if let airportName = airports["DUB"] {
                print("The name of the airport is \(airportName).")
            } else {
                print("That airport isn't in the airports dictionary.")
            }
            // Prints "The name of the airport is Dublin Airport."

            airports["APL"] = "Apple International"
            // "Apple International" isn't the real airport for APL, so delete it
            airports["APL"] = nil
            // APL has now been removed from the dictionary

        // removeValue(forKey:) method
            if let removedValue = airports.removeValue(forKey: "DUB") {
                print("The removed airport's name is \(removedValue).")
            } else {
                print("The airports dictionary doesn't contain a value for DUB.")
            }
            // Prints "The removed airport's name is Dublin Airport."


    // Iterating Over a Dictionary
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // LHR: London Heathrow
        // YYZ: Toronto Pearson

        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: LHR
        // Airport code: YYZ

        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: London Heathrow
        // Airport name: Toronto Pearson

        let airportCodes = [String](airports.keys)
        // airportCodes is ["LHR", "YYZ"]

        let airportNames = [String](airports.values)
        // airportNames is ["London Heathrow", "Toronto Pearson"]




