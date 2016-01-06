// nil coalescing
a ?? b // a != nil ? a! : b

// an example
let defaultColor = "red"
var userDefinedColor: String?

var colorToUse = userDefinedColor ?? defaultColor

// loop from 1 to 5
for i in 1...5 {

  ...
}

or

for i in 1..<6 {

  ...
}

// loop over an array using index
let arr = [1, 3, 5, 6]
for i in 0..<arr.count {

  ...
}
