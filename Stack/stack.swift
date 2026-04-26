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

struct LimitedArrayStack<I>: LimitedStackProtocol {
    private let limit: Int
    private var store: [I?]
    private var pointer = -1

    private var currentItem: I {
        get throws {
            guard !isEmpty else { throw StackError.underflow }
            guard (0..<limit).contains(pointer), let item = store[pointer]
            else { throw StackError.corruptedState }

            return item
        }
    }

    var isEmpty: Bool {
        pointer == -1
    }

    var isFull: Bool {
        pointer == limit - 1
    }

    init(limit: Int) {
        precondition(limit > 0, "limit must be > 0")

        self.limit = limit
        store = [I?](repeating: nil, count: limit)
    }

    mutating func push(_ item: I) throws {
        guard !isFull else { throw StackError.overflow }

        pointer += 1
        store[pointer] = item
    }

    mutating func pop() throws -> I {
        defer {
            store[pointer] = nil
            pointer -= 1
        }

        return try currentItem
    }

    func peek() throws -> I {
        try currentItem
    }
}

struct DynamicArrayStack<I>: StackProtocol {
    private var store = [I]()
    
    var isEmpty: Bool { store.isEmpty }
    
    private var currentItem: I {
        get throws {
            guard !isEmpty else { throw StackError.underflow }
            guard let item = store.last else { throw StackError.corruptedState }
            
            return item
        }
    }
    
    mutating func push(_ item: I) {
        store.append(item)
    }
    
    mutating func pop() throws -> I {
        defer { store.removeLast() }
        return try currentItem
    }
    
    func peek() throws -> I {
        return try currentItem
    }
}