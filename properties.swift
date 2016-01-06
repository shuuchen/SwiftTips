// properties
* used in class, structure, enumeration
* two kinds
 * stored properties (not for enumeration)
 * computed properties
* type
* observer

// stored properties
// variable/constant stored property (var/let)
struct FixedLengthRange {

    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

rangeOfThreeItems.firstValue = 6

// if the structure is assigned as "let", the property inside
// cannot be modified even if it is "var"
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)

rangeOfFourItems.firstValue = 6 // error

// lazy stored property
// initial value is not calculated until it is used
// must be "var"
// "let" property must have a value before initialization completes
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a non-trivial amount of time to initialize.
    */
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created

print(manager.importer.fileName)
// the DataImporter instance for the importer property has now been created
// prints "data.txt"

// computed properties
// do not actually store a value
// access through a getter & an optional setter
// like an inline method and related to a property
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// prints "square.origin is now at (10.0, 10.0)"

// read-only computed property
// only getter is declared
// thus "get" keyword can be removed
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// prints "the volume of fourByFiveByTwo is 40.0"

// property observers
// observe & respond to changes in a property's value
// called when property's value is set
// applied to stored properties (not lazy) & any inherited property
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

// global & local variables
* computing & observing properties above also work for global & local variables
* global vars & lets are always lazy, thus "lazy" keyword can be removed
* local vars & lets are never lazy

// type properties are lazy, must be initialized

// type property syntax
// using keyword static
// for computed type properties, use class keyword to allow subclass to override
struct SomeStructure {

    static var storedTypeProperty = "Some value."
    
    static var computedTypeProperty: Int {
    
        return 1
    }
}

enum SomeEnumeration {

    static var storedTypeProperty = "Some value."
    
    static var computedTypeProperty: Int {
    
        return 6
    }
}

class SomeClass {

    static var storedTypeProperty = "Some value."
    
    static var computedTypeProperty: Int {
    
        return 27
    }
    
    class var overrideableComputedTypeProperty: Int {
    
        return 107
    }
}

// querying & setting
print(SomeStructure.storedTypeProperty)

SomeStructure.storedTypeProperty = "Another value."

print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)

print(SomeClass.computedTypeProperty)

struct AudioChannel {

    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    
    var currentLevel: Int = 0 {
    
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)

print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)


print(AudioChannel.maxInputLevelForAllChannels)
