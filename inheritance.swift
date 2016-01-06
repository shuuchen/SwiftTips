// inheritance

// base class
class Vehicle {

    var currentSpeed = 0.0
    
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let someVehicle = Vehicle()

print("Vehicle: \(someVehicle.description)")

// subclassing
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {

    var currentNumberOfPassengers = 0
}

let tandem = Tandem()

tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0

print("Tandem: \(tandem.description)")

// overriding
// access super methods, properties, subscripts using "super" in subclass implementation
class Train: Vehicle {

    override func makeNoise() {
    
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

// overriding property
// properties inheritated from superclass are unknown of "stored" or "computed", they only have names and types
// "read-only" properties can be overriden as "read-write", but "read-write" properties cannot be overriden as "read-only"
// if u put a "setter" in an override, u must provide a "getter"

class Car: Vehicle {
    
    var gear = 1
    
    override var description: String {
        
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3

print("Car: \(car.description)")

// overriding property observers
// cannot add observers to "read-only" or "constant" properties (cannot be set)
// cannot provide both "setter" & observer for the same property (duplication)
class AutomaticCar: Car {

    override var currentSpeed: Double {
    
        didSet {
        
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0

print("AutomaticCar: \(automatic.description)")

// preventing overrides

// using "final" modifier
