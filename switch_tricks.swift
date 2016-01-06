// fallthrough

let integerToDescribe = 5

var description = "The number \(integerToDescribe) is"

switch integerToDescribe {
  case 2, 3, 5, 7, 11, 13, 17, 19:
      description += " a prime number, and also"
      fallthrough
  default:
      description += " an integer."
}

// interval

switch xxx {

  case 0..<5:
    ...
  case 7...9:
    ...
  default:
    ...
}


// tuple

let p = (0, 1)
switch p {
  case (0, 0):
    ...
  case (0..<4, 0...5):
    ...
  case (_, 3):
    ...
  default:
    ...
}

