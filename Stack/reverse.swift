func reverse<S: StackProtocol>(
    _ input: String,
    using stack: inout S
) throws -> String where S.Item == Character {
    var output = ""

    for char in input {
        try stack.push(char)
    }

    while !stack.isEmpty {
        output += String(try stack.pop())
    }

    return output
}

var testString = "Hello, World!"
var limitedArrayStack = LimitedArrayStack<Character>(limit: testString.count)
var dynamicArrayStack = DynamicArrayStack<Character>()

try reverse(testString, using: &limitedArrayStack)
try reverse(testString, using: &dynamicArrayStack)
