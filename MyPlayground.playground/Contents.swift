import UIKit

var greeting = "Hello, playground"

class Test {
    var test = 1
}

let test = Test()
let test2 = Test()
print(test.test)

test.test = 2
print(test.test)
print(test2.test)
