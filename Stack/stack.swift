enum StackError: Error { case overflow, underflow, corruptedState }

protocol StackProtocol {
    associatedtype Item
    
    var isEmpty: Bool { get }
    
    mutating func push(_ item: Item) throws -> Void
    mutating func pop() throws -> Item
    func peek() throws -> Item
}

protocol LimitedStackProtocol: StackProtocol {
    var isFull: Bool { get }
}

struct LimitedArrayStack<T>: LimitedStackProtocol {
    private let maxSize: Int
    private var stackArray: [T?]
    private var top = -1

    private var topItem: T {
        get throws {
            guard (0..<maxSize).contains(top), let item = stackArray[top]
            else { throw StackError.corruptedState }
            return item
        }
    }

    var isEmpty: Bool { top == -1 }
    var isFull: Bool { top == maxSize - 1 }

    init(maxSize: Int) {
        precondition(maxSize > 0, "maxSize must be > 0")
        self.maxSize = maxSize
        stackArray = [T?](repeating: nil, count: maxSize)
    }

    mutating func push(_ item: T) throws {
        guard !isFull else { throw StackError.overflow }
        top += 1
        stackArray[top] = item
    }

    mutating func pop() throws -> T {
        guard !isEmpty else { throw StackError.underflow }
        defer {
            stackArray[top] = nil
            top -= 1
        }
        return try topItem
    }

    func peek() throws -> T {
        guard !isEmpty else { throw StackError.underflow }
        return try topItem
    }
}

// TODO: DynamicArrayStack
// TODO: LinkedListStack


