[swift tips] extensions
// extensions
// can add new functionality, but cannot override
// cannot add stored properties & observers
extension SomeType {

    // new functionality to add to SomeType goes here
}

extension SomeType: SomeProtocol, AnotherProtocol {

    // implementation of protocol requirements goes here
}

// computed properties
extension Double {

    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm

print("One inch is \(oneInch) meters")
// prints "One inch is 0.0254 meters"

let threeFeet = 3.ft

print("Three feet is \(threeFeet) meters")
// prints "Three feet is 0.914399970739201 meters"

// initializers
// can only add convenience intializers for a class
// cannot add deinitializer
struct Size {

    var width = 0.0, height = 0.0
}

struct Point {

    var x = 0.0, y = 0.0
}

struct Rect {

    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
   
extension Rect {

    // designated initializers can be added to a structure
    init(center: Point, size: Size) {

        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)

        // call the automatic memberwise initializer in extionsion
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))
   
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

// methods
extension Int {

    func repetitions(task: () -> Void) {

        for _ in 0..<self {

            task()
        }
    }
}

3.repetitions {

    print("Goodbye!")
}

// mutating instance methods
extension Int {

    mutating func square() {

        self = self * self
    }
}

var someInt = 3

someInt.square()
// someInt is now 9

// subscripts
extension Int {

    subscript(var digitIndex: Int) -> Int {

        var decimalBase = 1

        while digitIndex > 0 {

            decimalBase *= 10
            --digitIndex
        }

        return (self / decimalBase) % 10
    }
}

746381295[0]
// returns 5

746381295[1]
// returns 9

// nested types
extension Int {

    enum Kind {

        case Negative, Zero, Positive
    }

    var kind: Kind {

        switch self {

        case 0:
            return .Zero

        case let x where x > 0:
            return .Positive

        default:
            return .Negative
        }
    }
}

func printIntegerKinds(numbers: [Int]) {
   
    for number in numbers {
   
        switch number.kind {
   
        case .Negative:
            print("- ", terminator: "")
   
        case .Zero:
            print("0 ", terminator: "")
   
        case .Positive:
            print("+ ", terminator: "")
        }
    }
   
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// prints "+ + - 0 - 0 +"
