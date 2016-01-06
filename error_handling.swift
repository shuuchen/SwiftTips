// error handling
// respond & recover from error condition at runtime

// represent & throw errors
// error types conform to ErrorType protocol
// to be used for error handling
enum VendingMachineError: ErrorType {

    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

// error handling
// four ways: propagation, do-catch, optional, assert

// propagating errors using throwing functions
// using "throws" keyword to mark a "throwing function"
func canThrowErrors() throws -> String

struct Item {

    var price: Int
    var count: Int
}

class VendingMachine {

    var inventory = [
   
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
   
    var coinsDeposited = 0
   
    func dispenseSnack(snack: String) {
   
        print("Dispensing \(snack)")
    }
   
    func vend(itemNamed name: String) throws {
   
        guard var item = inventory[name] else {
       
            throw VendingMachineError.InvalidSelection
        }
       
        guard item.count > 0 else {
       
            throw VendingMachineError.OutOfStock
        }
       
        guard item.price <= coinsDeposited else {
       
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
       
        coinsDeposited -= item.price
       
        --item.count
       
        inventory[name] = item
       
        dispenseSnack(name)
    }
}

// a "throwing function" is called either with "do-catch, try"
// or continue to propagate
let favoriteSnacks = [

    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {

    let snackName = favoriteSnacks[person] ?? "Candy Bar"

    try vendingMachine.vend(itemNamed: snackName)
}

// handling errors with "do-catch"
do {

    try expression
    statements
   
} catch pattern 1 {

    statements
   
} catch pattern 2 where condition {

    statements
}

var vendingMachine = VendingMachine()

vendingMachine.coinsDeposited = 8

do {

    // using "try" because it can throw an error
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
   
} catch VendingMachineError.InvalidSelection {

    print("Invalid Selection.")
   
} catch VendingMachineError.OutOfStock {

    print("Out of Stock.")
   
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {

    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
   
}

// prints "Insufficient funds. Please insert an additional 2 coins."

// converting errors to optional values
// using "try?" to call a "throwing function"
// if an error is thrown, the value of the expression is nil
// otherwise, the return value is wrapped to an optional
// the following x, y have the same value & behavior
func someThrowingFunction() throws -> Int {
    // ...
}

let x = try? someThrowingFunction()

let y: Int?

do {

    y = try someThrowingFunction()
   
} catch {

    y = nil
}

func fetchData() -> Data? {

    if let data = try? fetchDataFromDisk() { return data }

    if let data = try? fetchDataFromServer() { return data }

    return nil
}

// disabling error propagation
// using "try!" to wrap the call to runtime assertion
// if an error actually is thrown, you’ll get a runtime error
let photo = try! loadImage("./Resources/John Appleseed.jpg")

// specifiying cleanup actions
// use "defer" statement to defer execution just before current block is exited
// doing clean-up regardless of how the current block is exited
// executed in reverse order
func processFile(filename: String) throws {

    if exists(filename) {

        let file = open(filename)

        defer {

            close(file)
        }

        while let line = try file.readline() {

            // Work with the file.
        }

        // close(file) is called here, at the end of the scope.
    }
}

