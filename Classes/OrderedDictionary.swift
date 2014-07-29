//
//  OrderedDictionary.swift
//  M13OrderedDictionary
//
//  Created by Brandon McQuilkin on 7/26/14.
//  Copyright (c) 2014 Brandon McQuilkin. All rights reserved.
//

import Foundation

struct OrderedDictionary<KeyType: Hashable, ValueType>: Sequence, Printable {
    private var keyStorage: Array<KeyType> = []
    private var pairStorage: Dictionary<KeyType, ValueType> = [:]
    
    //MARK: Initalization
    
    /**Constructs an empty ordered dictionary.*/
    init() {
        
    }
    
    /**Constructs an ordered dictionary with the keys and values in a dictionary.*/
    init(dictionary: Dictionary<KeyType, ValueType>) {
        for aKey in dictionary.keys {
            keyStorage.append(aKey)
        }
        pairStorage = dictionary
    }
    
    /**Constructs an ordered dictionary with the keys and values from another ordered dictionary.*/
    init(orderedDictionary: OrderedDictionary<KeyType, ValueType>) {
        keyStorage = orderedDictionary.keyStorage
        pairStorage = orderedDictionary.pairStorage
    }
    
    //MARK: Subscripts
    
    /**Gets or sets existing entries in an ordered dictionary by key using square bracket subscripting. If a key exists this will overrite the object for said key, not changing the order of keys. If the key does not exist, it will be appended at the end of the ordered dictionary.*/
    subscript(key: KeyType) -> ValueType? {
        get {
            return pairStorage[key]
        }
        mutating set(newValue) {
            if let oldValue = pairStorage[key] {
                pairStorage[key] = newValue
            } else {
                keyStorage.append(key)
                pairStorage[key] = newValue
            }
        }
    }

    /**Gets or sets existing entries in an ordered dictionary by index using square bracket subscripting. If the key exists, its entry will be deleted, before the new entry is inserted; also, the insertion compensates for the deleted key, so the entry will end up between the same to entries regardless if a key is deleted or not.*/
    subscript(index: Int) -> (KeyType, ValueType) {
        get {
            let key: KeyType = keyStorage[index]
            let value: ValueType = pairStorage[key]!
            return (key, value)
        }
        set(newValue) {
            let (key: KeyType, value: ValueType) = newValue
            if let oldValue = pairStorage[key] {
                var idx: Int = 0
                if let keyIndex = find(keyStorage, key) {
                    if index > keyIndex {
                        //Compensate for the deleted entry
                        idx = index - 1
                    } else {
                        idx = index
                    }
                    
                    //Remove the old entry
                    keyStorage.removeAtIndex(keyIndex)
                    //Insert the new one
                    pairStorage[key] = value
                    keyStorage.insert(key, atIndex: idx)
                }
            } else {
                //No previous value
                keyStorage.insert(key, atIndex: index)
                pairStorage[key] = value
            }
        }
    }
    
    /**Gets or a subrange of existing keys in an ordered dictionary using square bracket subscripting with an integer range.*/
    subscript(#keyRange: Range<Int>) -> Slice<KeyType> {
        get {
            return keyStorage[keyRange]
        }
    }
    
    /**Gets or a subrange of existing values in an ordered dictionary using square bracket subscripting with an integer range.*/
    subscript(#valueRange: Range<Int>) -> Slice<ValueType> {
        get {
            return self.values[valueRange]
        }
    }
    
    //MARK: Adding
    
    /*Adds a new entry as the last element in an existing ordered dictionary.*/
    mutating func append(newElement: (KeyType, ValueType)) {
        let (key, value) = newElement
        pairStorage[key] = value
        keyStorage.append(key)
    }
    
    /*Inserts an entry into the collection at a given index. If the key exists, its entry will be deleted, before the new entry is inserted; also, the insertion compensates for the deleted key, so the entry will end up between the same to entries regardless if a key is deleted or not.*/
    mutating func insert(newElement: (KeyType, ValueType), atIndex: Int) {
        self[atIndex] = newElement
    }
    
    //MARK: Updating
    
    /**Inserts at the end or updates a value for a given key and returns the previous value for that key if one existed, or nil if a previous value did not exist.*/
    mutating func updateValue(value: ValueType, forKey: KeyType) -> ValueType? {
        var test: ValueType? = pairStorage.updateValue(value, forKey: forKey)
        if let myValue = test {
            //The key already exists, no need to add
        } else {
            keyStorage.append(forKey)
        }
        return test
    }
    
    //MARK: Removing
    
    /**Removes the key-value pair for the specified key and returns its value, or nil if a value for that key did not previously exist.*/
    mutating func removeEntryForKey(key: KeyType) -> ValueType? {
        if let index = find(keyStorage, key) {
            keyStorage.removeAtIndex(index)
        }
        return pairStorage.removeValueForKey(key)
    }
    
    /**Removes all the elements from the collection and clears the underlying storage buffer.*/
    mutating func removeAllEntries() {
        keyStorage.removeAll(keepCapacity: false)
        pairStorage.removeAll(keepCapacity: false)
    }

    /**Removes the entry at the given index and returns it.*/
    mutating func removeEntryAtIndex(index: Int) -> (KeyType, ValueType) {
        let key: KeyType = keyStorage[index]
        let value: ValueType = pairStorage.removeValueForKey(key)!
        keyStorage.removeAtIndex(index)
        return (key, value)
    }
    
    /**Removes the last entry from the collection and returns it.*/
    mutating func removeLastEntry() -> (KeyType, ValueType) {
        let key: KeyType = keyStorage[keyStorage.endIndex]
        let value: ValueType = pairStorage.removeValueForKey(key)!
        keyStorage.removeLast()
        return (key, value)
    }

    //MARK: Properties
    
    /**An integer value that represents the number of elements in the ordered dictionary (read-only).*/
    var count: Int { get {
        return keyStorage.count
    }}
    
    /**A Boolean value that determines whether the ordered dictionary is empty (read-only).*/
    var isEmpty: Bool { get {
        return keyStorage.isEmpty
    }}

    //MARK: Enumeration
    
    /*Returns an ordered iterable collection of all of an ordered dictionary’s keys.*/
    var keys: Array<KeyType> {
        get {
            return keyStorage
        }
    }
    
    /*Returns an ordered iterable collection of all of an ordered dictionary’s values.*/
    var values: Array<ValueType> {
        get {
            var tempArray: Array<ValueType> = []
            for key: KeyType in keyStorage {
                tempArray.append(pairStorage[key]!)
            }
            return tempArray
        }
    }
    
    /*Returns an ordered iterable collection of all of an ordered dictionary’s entries.*/
    var entries: Array<(KeyType, ValueType)> {
        get {
            var tempArray: Array<(KeyType, ValueType)> = []
            for key: KeyType in keyStorage {
                let temp = (key, pairStorage[key]!)
                tempArray.append(temp)
            }
            return tempArray
        }
    }
    
    //MARK: Sorting
    
    /**Sorts the receiver in place using a given closure to determine the order of a provided pair of elements.*/
    mutating func sort(isOrderedBefore sortFunction: ((KeyType, ValueType), (KeyType, ValueType)) -> Bool) {
        var tempArray = Array(pairStorage)
        tempArray.sort(sortFunction)
        keyStorage = tempArray.map({
            let (key, value) = $0
            return key
            })
    }
    
    /**Sorts the receiver in place using a given closure to determine the order of a provided pair of elements by their keys.*/
    mutating func sortByKeys(isOrderedBefore sortFunction: (KeyType, KeyType) -> Bool) {
        keyStorage.sort(sortFunction)
    }
    
    /**Sorts the receiver in place using a given closure to determine the order of a provided pair of elements by their values.*/
    mutating func sortByValues(isOrderedBefore sortFunction: (ValueType, ValueType) -> Bool) {
        var tempArray = Array(pairStorage)
        tempArray.sort({
            let (aKey, aValue) = $0
            let (bKey, bValue) = $1
            return sortFunction(aValue, bValue)
            })
        keyStorage = tempArray.map({
                let (key, value) = $0
                return key
            })
    }
    
    /**Returns an ordered dictionary containing elements from the receiver sorted using a given closure.*/
    func sorted(isOrderedBefore: ((KeyType, ValueType), (KeyType, ValueType)) -> Bool) -> OrderedDictionary<KeyType, ValueType> {
        var temp: OrderedDictionary = OrderedDictionary(orderedDictionary: self)
        temp.sort(isOrderedBefore: isOrderedBefore)
        return temp
    }
    
    /**Returns an ordered dictionary containing elements from the receiver sorted using a given closure by their keys.*/
    func sortedByKeys(isOrderedBefore: (KeyType, KeyType) -> Bool) -> OrderedDictionary<KeyType, ValueType> {
        var temp: OrderedDictionary = OrderedDictionary(orderedDictionary: self)
        temp.sortByKeys(isOrderedBefore: isOrderedBefore)
        return temp
    }
    
    /**Returns an ordered dictionary containing elements from the receiver sorted using a given closure by their values.*/
    func sortedByValues(isOrderedBefore: (ValueType, ValueType) -> Bool) -> OrderedDictionary<KeyType, ValueType> {
        var temp: OrderedDictionary = OrderedDictionary(orderedDictionary: self)
        temp.sortByValues(isOrderedBefore: isOrderedBefore)
        return temp
    }
    
    /**Returns an ordered dictionary containing the elements of the receiver in reverse order by index.*/
    func reverse() -> OrderedDictionary<KeyType, ValueType> {
        var temp = OrderedDictionary(orderedDictionary: self)
        temp.keyStorage = temp.keyStorage.reverse()
        return temp
    }
    
    /**Returns an ordered dictionary containing the elements of the receiver for which a provided closure indicates a match.*/
    func filter(includeElement filterFunction: ((KeyType, ValueType)) -> Bool) -> OrderedDictionary<KeyType, ValueType> {
        var tempArray = self.entries.filter(filterFunction)
        var temp = OrderedDictionary()
        for entry in tempArray {
            temp.append(entry)
        }
        return temp
    }
    
    /**Returns an ordered dictionary of elements built from the results of applying a provided transforming closure for each element.*/
    func map<NewKeyType, NewValueType>(transform aTransform: (KeyType, ValueType) -> (NewKeyType, NewValueType)) -> OrderedDictionary<NewKeyType, NewValueType> {
        var tempArray = Array(pairStorage)
        var newArray = tempArray.map(aTransform)
        var temp: OrderedDictionary<NewKeyType, NewValueType> = OrderedDictionary<NewKeyType, NewValueType>()
        for entry in newArray {
            temp.append(entry)
        }
        return temp
    }
    
    /**Returns an array of elements built from the results of applying a provided transforming closure for each element.*/
    func mapToArray<T>(transform aTransform: (KeyType, ValueType) -> T) -> Array<T> {
        var tempArray = Array(pairStorage)
        return tempArray.map(aTransform)
    }
    
    /**Returns a single value representing the result of applying a provided reduction closure for each element.*/
    func reduce<NewKeyType, NewValueType>(initial value: (NewKeyType, NewValueType), combine combo: ((NewKeyType, NewValueType), (KeyType, ValueType)) -> (NewKeyType, NewValueType)) ->  (NewKeyType, NewValueType) {
        var tempArray = Array(pairStorage)
        return tempArray.reduce(value, combine: combo)
    }
    
    //MARK: Printable
    var description: String {
        get {
            var temp: String = "OrderedDictionary {\n"
            let entries = self.entries
            var int = 0
            for entry in entries {
                let (key, value) = entry
                temp += "    [\(int)] {\(key): \(value)}\n"
            }
            temp += "}"
            return temp
        }
    }
    
    //MARK: Sequence
    func generate() -> IndexingGenerator<[(KeyType, ValueType)]> {
        return self.entries.generate()
    }
    
}

//MARK: Operators

/**Determines the equality of two ordered dictionaries. Evaluates to true if the two ordered dictionaries contain exactly the same keys and values in the same order.*/
func == <KeyType: Equatable, ValueType: Equatable>(lhs: OrderedDictionary<KeyType, ValueType>, rhs: OrderedDictionary<KeyType, ValueType>) -> Bool {
    return lhs.keyStorage == rhs.keyStorage && lhs.pairStorage == rhs.pairStorage
}

/**Determines the similarity of two ordered dictionaries. Evaluates to true if the two ordered dictionaries contain exactly the same keys and values but not necessarly in the same order.*/
func ~= <KeyType : Equatable, ValueType : Equatable>(lhs: OrderedDictionary<KeyType, ValueType>, rhs: OrderedDictionary<KeyType, ValueType>) -> Bool {
    return lhs.pairStorage == rhs.pairStorage
}

/**Determines the inequality of two ordered dictionaries. Evaluates to true if the two ordered dictionaries do not contain exactly the same keys and values in the same order*/
func != <KeyType : Equatable, ValueType : Equatable>(lhs: OrderedDictionary<KeyType, ValueType>, rhs: OrderedDictionary<KeyType, ValueType>) -> Bool {
    return lhs.keyStorage != rhs.keyStorage || lhs.pairStorage != rhs.pairStorage
}

