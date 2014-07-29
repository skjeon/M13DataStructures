//
//  Stack.swift
//  M13Stack
//
/*
Copyright 2014 Brandon McQuilkin
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/**A swift implementation of a stack that conforms to the sequence protocol.*/
struct Stack<T>: Sequence {
    
    private var items = [T]()
    
    init() {
        
    }
    
    init(objects: [T]) {
        items = objects
    }
    
    /**Push a item onto the stack.*/
    mutating func push(item: T) {
        items.append(item)
    }
    
    /**Push multiple items onto the stack.*/
    mutating func push(items: [T]) {
        self.items += items
    }
    
    /**Returns the top item on the stack.*/
    var peek: T? {
    return items.isEmpty ? nil : items[items.count - 1]
    }
    
    var count: Int {
        get {
            return items.count
        }
    }
    
    /**Remove the last item placed on the stack.*/
    mutating func pop() {
        items.removeLast()
    }
    
    /**Removes the given number of items that were last placed on the stack.*/
    mutating func pop(numberOfItems: UInt) {
        for i in 1 ..< numberOfItems {
            self.pop()
        }
    }
    
    /**Drops the first item placed on the stack.*/
    mutating func drop() {
        items.removeAtIndex(0)
    }
    
    /**Drops the given number of items from the end of the array.*/
    mutating func drop(numberOfItems: UInt) {
        for i in 1..<numberOfItems {
            self.drop()
        }
    }
    
    func generate() -> IndexingGenerator<[T]> {
        return items.reverse().generate()
    }
    
}

@infix func +=<T> (inout left: Stack<T>, right: T) {
    left.push(right)
}

@infix func +=<T> (inout left: Stack<T>, right: Stack<T>) {
    left.push(right.items)
}

@infix func +=<T> (inout left: Stack<T>, right: [T]) {
    left.push(right)
}

@infix func + <T> (left: Stack<T>, right: T) -> Stack<T> {
    var newStack: Stack<T> = Stack()
    newStack.push(left.items)
    newStack.push(right)
    return newStack
}

@infix func + <T> (left: Stack<T>, right: Stack<T>) -> Stack<T>{
    var newStack: Stack<T> = Stack()
    newStack.push(left.items)
    newStack.push(right.items)
    return newStack
}

@infix func + <T> (left: Stack<T>, right: [T]) -> Stack<T>{
    var newStack: Stack<T> = Stack()
    newStack.push(left.items)
    newStack.push(right)
    return newStack
}


