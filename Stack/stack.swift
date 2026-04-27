enum StackError: Error { case overflow }

protocol StackProtocol {
    associatedtype Item
    
    var isEmpty: Bool { get }
    var isFull: Bool { get }
    
    mutating func push(_ item: Item) -> Bool
    mutating func pushOrThrow(_ item: Item) throws
    mutating func pop() -> Item?

    func peek() -> Item?
}

struct PreallocatedStack<I>: StackProtocol {
    private var store: [I?]
    private var pointer = -1
    
    private var current: I? {
        guard store.indices.contains(pointer), let item = store[pointer]
        else { return nil }
        
        return item
    }

    var isEmpty: Bool { pointer == -1 }
    var isFull: Bool { pointer == store.count - 1 }

    init(limit: Int) {
        store = [I?](repeating: nil, count: limit)
    }

    mutating func push(_ item: I) -> Bool {
        guard !isFull else { return false }

        pointer += 1
        store[pointer] = item

        return true
    }
    
    mutating func pushOrThrow(_ item: I) throws {
        guard push(item) else { throw StackError.overflow }
    }

    mutating func pop() -> I? {
        guard let result = current else { return nil }
        
        store[pointer] = nil
        pointer -= 1

        return result
    }

    func peek() -> I? {
        current
    }
}

struct DynamicStack<I>: StackProtocol {
    private var store = [I]()
    private let limit: Int?
    
    var isEmpty: Bool { store.isEmpty }
    var isFull: Bool { store.count == limit }
    
    private var current: I? {
        store.last
    }
    
    init(limit: Int? = nil) {
        self.limit = limit
    }
    
    mutating func push(_ item: I) -> Bool {
        guard !isFull else { return false }

        store.append(item)
        return true
    }
    
    mutating func pushOrThrow(_ item: I) throws {
        guard push(item) else { throw StackError.overflow }
    }
    
    mutating func pop() -> I? {
        store.popLast()
    }
    
    func peek() -> I? {
        current
    }
}