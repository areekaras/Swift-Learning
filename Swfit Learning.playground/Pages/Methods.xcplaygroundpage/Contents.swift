


//Instance methods

//mutating
/*
struct Point {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self.x += deltaX
        self.y += deltaY
    }
}

var somePoint = Point(x: 4, y: 6)
print("somePoint is at x: \(somePoint.x) and y:\(somePoint.y) ") //4 6

somePoint.moveBy(x: 2, y: 2)
print("somePoint moved to x: \(somePoint.x) and y:\(somePoint.y) ") //6 8

let constantOrigin = Point(x: 0, y: 0)
//constantOrigin.moveBy(x: 2, y: 2)  //error: cannot use mutating member on immutable value: 'constantOrigin' is a 'let' constant
*/


/*
//assigning to self within mutating method
//the above example can be rewrite as
struct Point {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x: 3, y: 5)
print("somePoint is at x: \(somePoint.x) and y:\(somePoint.y) ") //4 6

somePoint.moveBy(x: 2, y: 2)
print("somePoint moved to x: \(somePoint.x) and y:\(somePoint.y) ") //6 8

//Another example with enum
enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off
ovenLight.next() //low
ovenLight.next() //high

 
 */



//Type methods
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {  //No need to call type property with type if inside type  method and self is implicitely available
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {  //Call with type name if inside of instance method
            currentLevel = level
            return true
        }
        return false
    }
}

class Player {
    var tracker = LevelTracker()
    let name: String
    
    func complete(_ level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        self.name = name
    }
}


var player = Player(name: "Shibili")
player.complete(2)

print("Highest unlocked level: \(LevelTracker.highestUnlockedLevel)")  //3

if player.tracker.advance(to: 4) {
    print("Player is moving to level 4")
} else {
    print("Level 4 is not unlocked!")  //this will print
}
