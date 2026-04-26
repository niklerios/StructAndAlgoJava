func reverse(_ input: String) throws -> String {
    var stack = ArrayStack<Character>(maxSize: input.count)
    var output = ""

    for char in input {
        try stack.push(char)
    }

    while !stack.isEmpty {
        output += String(try stack.pop())
    }

    return output
}
