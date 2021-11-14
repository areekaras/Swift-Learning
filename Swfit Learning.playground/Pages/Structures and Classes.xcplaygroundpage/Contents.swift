

/*
//Enumerations are value types
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

 */


//Classes are value types
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var name: String?
    var frameRate = 0.0
}

let hd = Resolution(width: 1920, height: 1080)

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("Frame rate \nTenEighty : \(tenEighty.frameRate)\nAlsoTenEighty : \(alsoTenEighty.frameRate)")


//identity operators === or !==

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer the same VideoMode instance")
}
