// class implementation
// can be implemented as designated & convenience
// "required" keyword is necessary for "non-final" classes
// to emphasize that all subclasses conform to the protocol
class SomeClass: SomeProtocol {

    required init(someParameter: Int) {

        // initializer implementation goes here
    }
}

protocol SomeProtocol {

    init()
}

class SomeSuperClass {

    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {

    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
   
        // initializer implementation goes here
    }
}

// failable initializer requirements
// ...

// protocols as types
class Dice {

    let sides: Int
    let generator: RandomNumberGenerator

    init(sides: Int, generator: RandomNumberGenerator) {

        self.sides = sides
        self.generator = generator
    }

    func roll() -> Int {

        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {

    print("Random dice roll is \(d6.roll())")
}

// delegation (design pattern)
// hand-off (or delegate) its responsibility to another type
protocol DiceGame {

    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {

    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {

    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]

    init() {

        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }

    var delegate: DiceGameDelegate?

    func play() {

        square = 0
        delegate?.gameDidStart(self)

        gameLoop: while square != finalSquare {

            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)

            switch square + diceRoll {

            case finalSquare:
                break gameLoop

            case let newSquare where newSquare > finalSquare:
                continue gameLoop

            default:
                square += diceRoll
                square += board[square]
            }
        }

        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {

    var numberOfTurns = 0
   
    func gameDidStart(game: DiceGame) {
   
        numberOfTurns = 0
       
        if game is SnakesAndLadders {
       
            print("Started a new game of Snakes and Ladders")
        }
       
        print("The game is using a \(game.dice.sides)-sided dice")
    }
   
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
    
        ++numberOfTurns
       
        print("Rolled a \(diceRoll)")
    }
   
    func gameDidEnd(game: DiceGame) {
   
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

// adding protocol conformance with an extension
protocol TextRepresentable {

    var textualDescription: String { get }
}

extension Dice: TextRepresentable {

    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())

print(d12.textualDescription)
// prints "A 12-sided dice"

extension SnakesAndLadders: TextRepresentable {

    var textualDescription: String {

        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDescription)
// prints "A game of Snakes and Ladders with 25 squares"

// declare protocol adoption with an extension
// already conforms to a protocol but not stated
struct Hamster {

    var name: String
   
    var textualDescription: String {
   
        return "A hamster named \(name)"
    }
}

// make it adopted with an empty extension
extension Hamster: TextRepresentable {}

// now can be used as a "TextRepresentable"
let simonTheHamster = Hamster(name: "Simon")

let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// prints "A hamster named Simon"

// collections of protocol types
let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {

    print(thing.textualDescription)
}
