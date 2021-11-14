
/*
//Swap two ints

func swapTwoInts(_ first: inout Int, _ second: inout Int) {
    let t = first
    first = second
    second = t
}


var a = 10
var b = 15

swapTwoInts(&a, &b)

print(a, b)
*/


/*
//Function as return types
func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
var moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print("Counting down to zero")

while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}

print("zero!")
 
*/


//Nested functions
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(_ input: Int) -> Int { input + 1 }
    func stepBackward(_ input: Int) -> Int { input - 1 }
    return backward ? stepBackward : stepForward
}

var currentValue = -4
var moveNearToZero = chooseStepFunction(backward: currentValue > 0)

print("Count down to zero")

while currentValue != 0 {
    print("\(currentValue)")
    currentValue = moveNearToZero(currentValue)
}

print("zero!")
