// class inheritance & initialization
// designated & convenience initializers

// initializer delegation for class types
// A designated initializer must call a designated initializer from its immediate superclass.
// A convenience initializer must call another initializer from the same class.
// A convenience initializer must ultimately call a designated initializer.

// two-phase initialization
// step 1: each stored property is assigned an initial value
// step 2: customize stored properties further
// safe

// convenience intializer cannot modify any stored properties before a designated initializer is called within it

// initializer inheritance & overriding
// by default, swift subclasses do not inherite their superclasses initializers
// using "override" when overriding a superclass' designated initializer, even for subclasses' convenience initializers
// do not use "override" when overriding a superclass' convenience initializer
class Vehicle {

    var numberOfWheels = 0
    
    var description: String {
    
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {

    override init() {
    
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

// automatic initializer inheritance
// if you provided default values for any new properties in the subclass :
// if subclass does not define any (designated) initializer, it inherites all of superclass's (designated) initializers
// if subclass inherites all of superclass's designated initializers, it automatically inherites all of superclass's convenience initializers

class Food {
    
    var name: String

    init(name: String) {
        
        self.name = name
    }
    
    convenience init() {
    
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")

let mysteryMeat = Food()

class RecipeIngredient: Food {

    var quantity: Int
    
    init(name: String, quantity: Int) {
    
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
    
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {

    var purchased = false
    
    var description: String {
    
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [

    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true

for item in breakfastList {

    print(item.description)
}

// failable initializers
// define which initializer can fail, using "init?"
// create an optional value of the type it initializes, using "return nil" to trigger initialization failure
struct Animal {

    let species: String
    
    init?(species: String) {
    
        if species.isEmpty { return nil }
        
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")

if let giraffe = someCreature {
    
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    
    print("The anonymous creature could not be initialized")
}

// failable initializers for enumerations
// trigger initialization failure if the provided parameters do not match a case
enum TemperatureUnit {

    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
    
        switch symbol {
        
        case "K":
            self = .Kelvin
        
        case "C":
            self = .Celsius
        
        case "F":
            self = .Fahrenheit
        
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")

if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")

if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")

}

// with raw values
// automatically recieve a failable initializer: init?(rawValue:)
enum TemperatureUnit2: Character {
    
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit2(rawValue: "F")

if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit2 = TemperatureUnit2(rawValue: "X")

if unknownUnit2 == nil {
    print("This is not a defined temperature unit, so initialization failed.")


}
