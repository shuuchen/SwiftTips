// protocols

protocol SomeProtocol {

    // protocol definition goes here
}

struct SomeStructure: FirstProtocol, AnotherProtocol {

    // structure definition goes here
}

// superclass name should come first
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {

    // class definition goes here
}

// property requirements
// only specify name & type, always "var"
protocol SomeProtocol {

    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

// use "static" keyword if it is a type property
protocol AnotherProtocol {

    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {

    var fullName: String { get }
}

struct Person: FullyNamed {

    var fullName: String
}

let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"

class Starship: FullyNamed {

    var prefix: String?
    var name: String

    init(name: String, prefix: String? = nil) {

        self.name = name
        self.prefix = prefix
    }

    var fullName: String {

        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"

// method requirements
protocol SomeProtocol {

    static func someTypeMethod()
}

protocol RandomNumberGenerator {

    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {

    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0

    func random() -> Double {

        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()

print("Here's a random number: \(generator.random())")
// prints "Here's a random number: 0.37464991998171"

print("And another one: \(generator.random())")
// prints "And another one: 0.729023776863283"

// mutating method requirements
// if conforming type is class, drop "mutating" keyword
protocol Togglable {

    mutating func toggle()
}

enum OnOffSwitch: Togglable {

    case Off, On

    mutating func toggle() {

        switch self {

        case Off:
            self = On

        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off

lightSwitch.toggle()
// lightSwitch is now equal to .On

// initializer requirements
protocol SomeProtocol {

    init(someParameter: Int)
}
