// deinitialization
// called just before an instance is deallocated

// only for class types, at most one per class
// when working with resources: files, notifications, etc.
deinit {

    // perform the deinitialization
}

// in action
class Bank {

    static var coinsInBank = 10_000

    static func vendCoins(var numberOfCoinsToVend: Int) -> Int {

        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }

    static func receiveCoins(coins: Int) {

        coinsInBank += coins
    }
}

class Player {

    var coinsInPurse: Int

    init(coins: Int) {

        coinsInPurse = Bank.vendCoins(coins)
    }

    func winCoins(coins: Int) {

        coinsInPurse += Bank.vendCoins(coins)
    }

    deinit {

        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)

print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// prints "A new player has joined the game with 100 coins"

print("There are now \(Bank.coinsInBank) coins left in the bank")
// prints "There are now 9900 coins left in the bank"

playerOne!.winCoins(2_000)

print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// prints "PlayerOne won 2000 coins & now has 2100 coins"

print("The bank now only has \(Bank.coinsInBank) coins left")
// prints "The bank now only has 7900 coins left"

playerOne = nil

print("PlayerOne has left the game")
// prints "PlayerOne has left the game"

print("The bank now has \(Bank.coinsInBank) coins")
// prints "The bank now has 10000 coins"

