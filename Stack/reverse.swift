func reverse<S: StackProtocol>(
    _ input: String,
    using stack: inout S
) -> String where S.Item == Character {
    var output = ""
    
    output.reserveCapacity(input.count)

    for char in input {
        guard stack.push(char) else { fatalError("stackoverflow") }
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

reverse(testString, using: &limitedArrayStack)
reverse(testString, using: &dynamicArrayStack)
