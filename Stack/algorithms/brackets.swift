func checkBrackets<S: StackProtocol>(
    _ input: String,
    using stack: inout S
) -> Bool where S.Item == Character {
    for current in input {
        switch current {
            case "(", "[", "{":
                stack.push(current)
            case ")", "]", "}":
                guard
                    let pair = stack.pop(),
                    (current == "}" && pair == "{") ||
                    (current == "]" && pair == "[") ||
                    (current == ")" && pair == "(")
                else {
                    return false
                }
            default:
                continue
        }
    }
    
    return stack.isEmpty
}
