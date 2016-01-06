// failable initializers for classes
// for value types, initialization faliure can be triggered at any point of the failable initializer
// for classes, it can only be triggered after all stored properties are set & all initializer delegations are finished
class Product {

    let name: String!
    
    init?(name: String) {
    
        self.name = name
        if name.isEmpty { return nil }
    }
}

if let bowTie = Product(name: "bow tie") {

    print("The product's name is \(bowTie.name)")
}

// propagation of initialization failure
// failable initializer can delegate another failable (or non-failable) initializer across the same class or from superclass
// if initialization failure is triggered at any point in the process, the initialization fails immediately
class CartItem: Product {

    let quantity: Int!
    
    init?(name: String, quantity: Int) {
    
        self.quantity = quantity
        
        super.init(name: name)
        
        if quantity < 1 { return nil }
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {

    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {

    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
    
} else {
    
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {

    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
    
} else {
    
    print("Unable to initialize one unnamed product")
}

// overriding a failable initializer
// a superclass failable initializer can be overriden by a subclass non-failable initializer, but not the other way around
// in this case, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer
class Document {

    var name: String?
    
    // this initializer creates a document with a nil name value
    init() {}
    
    // this initializer creates a document with a non-empty name value
    init?(name: String) {
    
        self.name = name
        if name.isEmpty { return nil }
    }
}

class AutomaticallyNamedDocument: Document {

    override init() {
    
        super.init()
        
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        
        super.init()
        
        if name.isEmpty {
        
            self.name = "[Untitled]"
            
        } else {
            
            self.name = name
        }
    }
}

class UntitledDocument: Document {

    override init() {
    
        // force-unwrap
        // here, a runtime error will occur if nil is returned
        super.init(name: "[Untitled]")!
    }
}

// init! failable initializer
// init? creates an optional instance of the appropriate type
// init! creates an implicitly unwrapped optional instance of the appropriate type
// init! & init? can be delegated, overriden through each other
// delegate from init to init! is allowed, although doing so will trigger an assertion if init! causes initialization to fail

// required initializers
// every subclass is required to implement the initializer
// use "required" instead of "override" when overriding a required designated initializer
class SomeClass2 {
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass2 {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}

// setting a default property value with a closure or function
// provide a customized default value for that property
// since the instance has not been initialized yet, other properties, methods or self cannot be used in closure
class SomeClass {

    let someProperty: SomeType = {
        
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
        }() // use "()" to run the closure immediately
}

struct Checkerboard {

    let boardColors: [Bool] = {
    
        var temporaryBoard = [Bool]()
        var isBlack = false
        
        for i in 1...10 {
            for j in 1...10 {
        
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            
            isBlack = !isBlack
        }
        
        return temporaryBoard
        }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
    
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()

print(board.squareIsBlackAtRow(0, column: 1))
// prints "true"

print(board.squareIsBlackAtRow(9, column: 9))

// prints "false"
