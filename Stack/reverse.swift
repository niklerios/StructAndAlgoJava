func doRev(input: String) -> String {
    var theStack = StackX<Character>(maxSize: input.count)
    var output = ""

    for ch in input {
        try? theStack.push(ch)
    }

    while !theStack.isEmpty {
        do {
            output += String(try theStack.pop())
        } catch {
            break;
        }
    }

    return output
}
