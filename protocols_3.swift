// protocol inheritance
// syntax is like class inheritance, but can inherit several protocols
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {

    // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {

    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {

    var prettyTextualDescription: String {

        var output = textualDescription + ":\n"

        for index in 1...finalSquare {

            switch board[index] {

            case let ladder where ladder > 0:
                output += "▲ "

            case let snake where snake < 0:
                output += "▼ "

            default:
                output += "○ "
            }
        }

        return output
    }
}

print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○

// Class-Only Protocols
// limit protocol adoption to class types
// used when conforming type is required to have reference semantics
protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {

    // class-only protocol definition goes here
}

// protocol composition
// combine multiple protocols into a single requirement
// form: "protocol<p1, p2>"
protocol Named {

    var name: String { get }
}

protocol Aged {

    var age: Int { get }
}

struct Person: Named, Aged {

    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>) {

    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
// prints "Happy birthday Malcolm - you're 21!"

// checking for protocol conformance
// use "is" to check, use "as" to downcast
protocol HasArea {

    var area: Double { get }
}

class Circle: HasArea {

    let pi = 3.1415927
    var radius: Double

    var area: Double { return pi * radius * radius }

    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {

    var area: Double

    init(area: Double) { self.area = area }
}

class Animal {

    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [

    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {

    if let objectWithArea = object as? HasArea {

        print("Area is \(objectWithArea.area)")

    } else {

        print("Something that doesn't have an area")
    }
}

// optional protocol requirements
// using "optional" modifier, the specified type is wrapped to optional
// only for protocols marked with "@objc" attribute
// can only be adopted by "@objc" classes
// cannot be adopted by structures & enumetations
// called with optional chaining
@objc protocol CounterDataSource {

    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {

    var count = 0
    var dataSource: CounterDataSource?

    func increment() {

        if let amount = dataSource?.incrementForCount?(count) {

            count += amount

        } else if let amount = dataSource?.fixedIncrement {

            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {

    let fixedIncrement = 3
}

var counter = Counter()

counter.dataSource = ThreeSource()

for _ in 1...4 {

    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {

    func incrementForCount(count: Int) -> Int {

        if count == 0 {

            return 0

        } else if count < 0 {

            return 1

        } else {

            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()

for _ in 1...5 {

    counter.increment()
    print(counter.count)
}

// protocol extensions
// protocols can be extended to provide behaviors themselves
// all conforming types automatically gain this method implementation
extension RandomNumberGenerator {

    func randomBool() -> Bool {

        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()

print("Here's a random number: \(generator.random())")
// prints "Here's a random number: 0.37464991998171"

print("And here's a random Boolean: \(generator.randomBool())")
// prints "And here's a random Boolean: true"

// providing default implementations
// use protocol extension to provide default implementation
extension PrettyTextRepresentable  {

    var prettyTextualDescription: String {
        return textualDescription
    }
}

// adding constraints to protocol extensions
// specify constraints that conforming types must satisfy
// before the extension is available
// using "where" clause
extension CollectionType where Generator.Element: TextRepresentable {

    var textualDescription: String {

        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")

let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
