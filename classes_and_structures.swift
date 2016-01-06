// classes & structures

// swift classes & structures are much closer in functionality
// than other languages, thus "instance" is used instead of "object"

// common points shared by both
* define properties, methods, subscripts, initializers
* expand functionality beyond a default implementation
* conform to protocols

// points for classes only
* inheritance
* type casting -- check & interpret type at runtime
* deinitializer -- free up resources
* reference counting -- more than one reference

// definition
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// creating instances
let someResolution = Resolution()
let someVideoMode = VideoMode()

// structures & enumerations are value types

// classes are reference types

// identity operators (===, !==)
// check if refers to the same instance
// called identical to, not the same as equal to (==),
// which compares values

// most custom data constructs should be classes

// some swift basic types such as String, Array, Dictionary
// are implemented as structures
