struct StackX {
    private let maxSize: Int
    private var stackArray: [Int]
    private var top = -1

    var isEmpty: Bool {
        top == -1
    }

    var isFull: Bool {
        top == maxSize - 1
    }

    init(maxSize: Int) {
        self.maxSize = maxSize
        stackArray = [Int](repeating: 0, count: maxSize)
    }

    mutating func push(_ j: Int) {
        top += 1
        stackArray[top] = j
    }

    mutating func pop() -> Int {
        let value = stackArray[top]
        top -= 1
        return value
    }

    func peek() -> Int {
        stackArray[top]
    }
}
