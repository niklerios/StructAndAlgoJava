func reverse<S: StackProtocol>(_ input: String, using stack: inout S) throws -> String where S.Item == Character {
    var output = ""

    for char in input {
        try stack.push(char)
    }

    while !stack.isEmpty {
        output += String(try stack.pop())
    }

    return output
}

var arrayStack = ArrayStack<Character>(maxSize: 10)
let string = "abcd"

try reverse(string, using: &arrayStack)
