// methods
// functions associated with a type
// class/structure/enumeration can define instance/type methods

// instance methods
// exact the same syntax as functions
class Counter {
    
    var count = 0

    func increment() {
        ++count
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()

counter.increment()

counter.incrementBy(5)

counter.reset()

// modifying value types from within instance methods
// by default, value types cannot be modified by instance methods
// use "mutating" keyword
// not for "let" value types
struct Point {
    
    var x = 0.0, y = 0.0
    
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
    
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)

somePoint.moveByX(2.0, y: 3.0)

print("The point is now at (\(somePoint.x), \(somePoint.y))")

// assigning to self
struct Point2 {
    
    var x = 0.0, y = 0.0
    
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
    
        self = Point2(x: x + deltaX, y: y + deltaY) // assign an entirely new instance to self
    }
}

// "mutating" methods in enumeration
// modify self to a new case
enum TriStateSwitch {

    case Off, Low, High
    
    mutating func next() {
    
        switch self {
        
        case Off:
            self = Low
        
        case Low:
            self = High
        
        case High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low

ovenLight.next()

ovenLight.next()

// type methods
// using "static" keyword
// using "class" keyword to allow subclasses to override
// in which "self" refers to type, not instance
class SomeClass {
    
    class func someTypeMethod() {
    
        println("class func")
    }
}

SomeClass.someTypeMethod()

struct LevelTracker {
    
    static var highestUnlockedLevel = 1
    
    static func unlockLevel(level: Int) {
    
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
    
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    
    mutating func advanceToLevel(level: Int) -> Bool {
    
        if LevelTracker.levelIsUnlocked(level) {
        
            currentLevel = level
            return true
            
        } else {
            
            return false
        }
    }
}

class Player {

    var tracker = LevelTracker()
    
    let playerName: String
    
    func completedLevel(level: Int) {
    
        LevelTracker.unlockLevel(level + 1)
        
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String) {
    
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")

if player.tracker.advanceToLevel(6) {
    
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")

}
