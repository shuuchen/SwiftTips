// an empty tuple of type Void is returned if return value is not specified
func greeting(name: String) {
    
    println("hello \(name)")
}
let retVal = greeting("Jimmy") // (0 elements)

// return a tuple
func minMax(arr: [Int]) -> (min: Int, max: Int) {
    
    var min = arr[0]
    var max = arr[0]
    
    for i in arr {
        
        if i < min {
            min = i
        }
        
        if i > max {
            max = i
        }
    }
    
    return (min, max)
}

let bounds = minMax([4, 6, 2, 6, 3, 45])

bounds.min

bounds.max

// return an optional tuple
// usually with safety check
// the entire tuple can be nil
func _minMax(arr: [Int]) -> (min: Int, max: Int)? {
    
    // safety check
    if arr.isEmpty {
        return nil
    }
    
    var min = arr[0]
    var max = arr[0]
    
    for i in arr {
        
        if i < min {
            min = i
        }
        
        if i > max {
            max = i
        }
    }
    
    return (min, max)
}

// use optional binding to accesss the return value
if let bounds = _minMax([4, 6, 2, 6, 3, 45]) {
    bounds.max
    bounds.min
}

// external parameter name
// used to invoke the function
// must be always labeled
func hello(from me: String, to you: String) -> String {
    
    return "say hello from \(me) to \(you)"
}

hello(from: "Jimmy", to: "Maggie")

// external parameter name can be omitted
// by using _
// may not work before v2.1
func something(str: String, knows: Bool) -> String {
    
    if knows {
        
        return "I know \(str)"
        
    } else {
        
        return "I dont know \(str)"
        
    }
}

something("drink house", true)

// variadic parameters
// 0 or more value of a specific type
// used as a constant array within function
// a function may have at most 1 variadic parameter
func average(numbers: Double...) -> Double {
    
    var total = 0.0
    
    for n in numbers {
    
        total += n
    }
    
    return total / Double(numbers.count)
}

average(4.5, 5, 90, 2.8)

// variable parameters
// parameters are constant by default
// using var to specify variable parameter, can be used as a local variable
// use return value to get the varied parameter (not like pointer in C)
func fillRight(var str: String, numOfBit: Int, c: Character) -> String {
    
    for _ in 0..<numOfBit {
        
        str.append(c)
    }
    
    return str
}

fillRight("Rox", 5, "-")

// inout parameters
// like pointer parameter in C, also use & to invoke
// cannot be a constant or a literal value
func swap(inout a: Int, inout b: Int) {
    
    var tmp = a
    a = b
    b = tmp
}

var a = 5
var b = 9

swap(&a, &b)

a
b

// function type
// like function pointer in C
// can be used for function assignment
// determined by the types of both parameters and return values
let ava: (Double...) -> Double = average
let _ava = average // auto type inference by Swift

ava(23.5, 76.8, 9, 0.8, 1, 5)

// can be used as parameters to other functions
// the function implementation depends on the parameter
func add(a: Int, b: Int) -> Int {
    
    return a + b
}

func sub(a: Int, b: Int) -> Int {
    
    return a - b
}

func printMathResult(mathFunc: (Int, Int) -> Int, a: Int, b: Int) {
    
    println("math result of a and b is \(mathFunc(a, b))")
}

printMathResult(add, 5, 7)

// can be used as return values
func chooseMathFunc(isAdd: Bool) -> (Int, Int) -> Int {
    
    return isAdd ? add : sub
}

var mathFunc = chooseMathFunc(true)

mathFunc(5, 6)

// nested function
// function defined in the scope of another function
// are hidden outside of the scope but can be returned to use in another scope
func chooseMathFunc2(isMul: Bool) -> (Int, Int) -> Int {
    
    func mul(a: Int, b: Int) -> Int {
        
        return a * b
    }
    
    func div(a: Int, b: Int) -> Int {
        return a / b
    }
    
    return isMul ? mul : div
}

mathFunc = chooseMathFunc2(false)

mathFunc(9, 3)
