// enumeration
// defined as a new type, starting with capital letter

// the cases are not implicitly assigned a integer values
enum CompassPoint {

    case North
    case South
    case East
    case West
}

CompassPoint.North

// can be written on a single line seperated with commas
enum Planet {

    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// p 's type is inferred to Planet
var p = Planet.Saturn

// assigne another value of Planet in which the type can be dropped
p = .Earth

// match individual enumeration values with a switch statement
var directionToHead = CompassPoint.South

switch directionToHead {
    
case .North:
    print("Lots of planets have a north")

case .South:
    print("Watch out for penguins")

case .East:
    print("Where the sun rises")

case .West:
    print("Where the skies are blue")
}

// match all the cases, or using default
switch directionToHead {
    
case .North:
    print("Lots of planets have a north")
    
case .South:
    print("Watch out for penguins")
    
default:
    println("...")
}

// associated values
// to store additional custom infomation alongside case value

// barcode with distinctive types
enum Barcode {

    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

// the same variable can be assigned with a different type
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

// check with a switch statement
// extract associate values with let or var
switch productBarcode {

case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")

case .QRCode(var productCode):
    print("QR code: \(productCode).")
}

// briefly written
switch productBarcode {
    
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
    
case var .QRCode(productCode):
    print("QR code: \(productCode).")
}

// raw values
// also known as default values
// defined uniquely with the same type
enum ASCIIControlCharacter: Character {

    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

// implicitly assigned raw values
// for integer or string raw values
enum Planet2: Int {

    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// when string is used, the implicit value is the text of the case's name
// the values should be explicitly specified until v2.1
enum CompassPoint2: String {

    case North = "north", South = "south", East = "east", West = "west"
}

CompassPoint2.South.rawValue // access with rawValue property

// init with raw value
let pp = Planet2(rawValue: 7) // pp may be nil, so it's type is Planet?

pp?.rawValue // access with optional chaining

// recursive enumeration
// not availible until v2.1
enum ArithmeticExpression {
    
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)

}
