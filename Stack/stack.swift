enum StackError: Error {
    case overflow
    case underflow
}

struct StackX<T> {
    private let maxSize: Int
    private var stackArray: [T?]
    private var top = -1

    private var topItem: T {
        guard let item = stackArray[top] else {
            fatalError("Unexpected nil value at top of stack")
        }

        return item
    }

    var isEmpty: Bool { top == -1 }
    var isFull: Bool { top == maxSize - 1 }

    init(maxSize: Int) {
        self.maxSize = maxSize
        stackArray = [T?](repeating: nil, count: maxSize)
    }

    mutating func push(_ item: T) throws {
        if isFull {
            throw StackError.overflow
        }

        top += 1
        stackArray[top] = item
    }

    mutating func pop() throws -> T {
        guard !isEmpty else {
            throw StackError.underflow
        }

        defer {
            stackArray[top] = nil
            top -= 1
        }

        return topItem
    }

    func peek() throws -> T {
        guard !isEmpty else {
            throw StackError.underflow
        }

        return topItem
    }
}
