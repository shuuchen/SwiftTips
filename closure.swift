// closures

// sort an array using sort()

let arr = ["a", "b", "c"]

(String, String) -> (Bool)

// using normal function
func backwards(str1: String, str2: String) -> Bool {

  return str1 > str2
}

arr.sort(backwards)

// using closure expression syntax
+++++++++++++++++++++++++++++++++++++
general form                                        

  { (parameters) -> return type in            
    statements                                      
  }                                                    
+++++++++++++++++++++++++++++++++++++
* parameters can be constants, variables, inout

arr.sort({ (str1: String, str2: String) -> Bool in

  return str1 > str2
})

// written in one line is OK
arr.sort({ (str1: String, str2: String) -> Bool in return str1 > str2})

// the types of parameters & return values can be inferred
// thus needless to specify
arr.sort({str1, str2 in return str1 > str2})

// single expression closure can return implicitly
// thus return can be omitted
arr.sort({str1, str2 in str1 > str2})

// swift provides shorthand argument names: $0, $1, $2...
// argument list can be omitted
arr.sort({ $0 > $1 })

// using string-specific implementation of ">" operator
arr.sort(>)

// trailing closures
// if the closure is passed as final argument
arr.sort() { $0 > $1 }
var a = [1, 2, 3, 4, 5]

// sort
// trailing closure
a.sort() { $0 > $1 }

// "()" can be omitted if closure is the only argument
a.sort { $0 < $1 }

// map
let m = [0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five"]

let mm = a.map {

    n -> String in
    
    return m[n]! // may be nil, thus force-unwrap is necessary
}

let mmm = a.map { m[$0]! }
mmm

// capturing values
// ...

// closures are reference types

// escaping & nonescaping closure
// when a closure is passed to a function
// escaping closure is called after function returned
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {

    closure()
}

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: () -> Void) {

    completionHandlers.append(completionHandler)
}

class SomeClass {
    
    var x = 10
    
    func doSomething() {
    
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoescapeClosure { x = 200 }
    }
}

let instance = SomeClass()

instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

// auto closure
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

// pass a closure to a fucntion
func serveCustomer(customerProvider: () -> String) {
    
    print("Now serving \(customerProvider())!")
}

serveCustomer { customersInLine.removeAtIndex(0) } // the type of the closure is () -> String

// using @autoclosure
func serveCustomer(@autoclosure customerProvider: () -> String) {
    
    print("Now serving \(customerProvider())!")
}

// single expression
// no argument
serveCustomer(customersInLine.removeAtIndex(0))
