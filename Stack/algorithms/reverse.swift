func reverse<S: StackProtocol>(
    _ input: String,
    using stack: inout S
) throws -> String where S.Item == Character {
    var output = ""
    
    output.reserveCapacity(input.count)

    for char in input {
        try stack.pushOrThrow(char)
    }

    while !stack.isEmpty {
        guard let char = stack.pop() else {
            fatalError("incorrect stack behavior")
        }
        output.append(char)
    }

    return output
}

var testString = "Hello, World!"
var limitedArrayStack = PreallocatedStack<Character>(limit: testString.count)
var dynamicArrayStack = DynamicStack<Character>(limit: testString.count)

try reverse(testString, using: &limitedArrayStack)
try reverse(testString, using: &dynamicArrayStack)
