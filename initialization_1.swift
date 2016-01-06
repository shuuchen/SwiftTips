// initialization
// initialize all the stored property for use

// initializer
struct Fahrenheit {

    var temperature: Double
    
    init() {
    
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

// default property values
// ...

// customizing initialization
// initialization parameters
struct Celsius {

    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
    
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
    
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
     
        temperatureInCelsius = celsius
    }
}

// use external parameter names to choose appropriate initializer
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

// local & external parameter names
struct Color {

    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
    
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(white: Double) {
    
        red   = white
        green = white
        blue  = white
    }
}

// external parameter names are always required
// swift
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// without external names
let bodyTemperature = Celsius(37.0)

// optional property types
// automaticlally initialized to "nil"
class SurveyQuestion {

    let text: String
    var response: String?
    
    init(text: String) {
    
        // assigning constant properties during initialization
        // once set, it cannot be modified
        self.text = text
    }
    
    func ask() {
    
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")

cheeseQuestion.ask()

cheeseQuestion.response = "Yes, I do like cheese."

// default initializers
// if all the properties have default values & no initializer exists
class ShoppingListItem2 {

    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem2()

// default memberwise initializers for structure types, classes do not have
struct Size {

    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)

// initializer delegation for value types
// call another initializer from an initializer, avoiding duplication
struct Point {

    var x = 0.0, y = 0.0
}

struct Rect {

    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin: Point, size: Size) {
    
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),

    size: Size(width: 3.0, height: 3.0))
