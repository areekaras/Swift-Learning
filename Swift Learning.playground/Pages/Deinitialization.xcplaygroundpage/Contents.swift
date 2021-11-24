

//MARK:- DEINITIALIZATION
    //A deinitializer is called immediately before a class instance is deallocated.
    //You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword.
    //Deinitializers are only available on class types.
    //Swift automatically deallocates your instances when they’re no longer needed, to free up resources. Swift handles the memory management of instances through automatic reference counting (ARC),
    //Deinitializers are called automatically, just before instance deallocation takes place. You aren’t allowed to call a deinitializer yourself.
    //Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation.
    //Superclass deinitializers are always called, even if a subclass doesn’t provide its own deinitializer.
    //Because an instance isn’t deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it’s called on and can modify its behavior based on those properties

class Bank {
    static var coinsInBank = 10_000
    
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(coinsInBank, numberOfCoinsRequested)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func won(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {  //return the coins to bank when instance denitialize
        Bank.receive(coins: coinsInPurse)
    }
}


var playerOne: Player? = Player(coins: 100)
print("Player recieves \(playerOne!.coinsInPurse) coins") // 100
print("Coins left in bank: \(Bank.coinsInBank)") //9900

playerOne!.won(coins: 2_000)
print("now player one has \(playerOne!.coinsInPurse) coins") //2100
print("Coins left in bank: \(Bank.coinsInBank)") //7900

playerOne = nil
print("Player one has left the game")
print("Coins left in bank: \(Bank.coinsInBank)") //10000
