//
//  Matrix.swift
//  M13DataStructures
//
//  Created by Brandon McQuilkin on 7/27/14.
//  Copyright (c) 2014 BrandonMcQuilkin. All rights reserved.
//

/**A swift implementation of a 2D Matrix. Eventually operators and operations will be added, but I have no idea how to check if <T> responds to +, -, *, /, etc... If you are reading this and know, please file an issue explaing how.*/
struct Matrix<T> {
    var rows: Int
    var columns: Int
    var grid: [Array<T>]
    
    
    //MARK: Initalization
    init(rows: Int, columns: Int, repeatedValue: T) {
        self.rows = rows
        self.columns = columns
        self.grid = []
        for i in 0..<rows - 1 {
            grid[i] = Array(count: columns, repeatedValue: repeatedValue)
        }
    }
    
    //MARK: Checks
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    //MARK: Subscripts
    subscript(row: Int, column: Int) -> T{
        get {
            assert(indexIsValid(row, column: column), "Index out of range")
            return grid[row][column]
        }
        mutating set(newValue) {
            assert(indexIsValid(row, column: column), "Index out of range")
            grid[row][column] = newValue
        }
    }
    
    subscript(#row: Int) -> Array<T> {
        get {
            assert(row >= 0 && row < rows, "Index out of range")
            return grid[row]
        }
        mutating set (newValue) {
            assert(row >= 0 && row < rows, "Index out of range")
            assert(newValue.count == columns, "New row has incorrect length")
            grid[row] = newValue
        }
    }
    
    subscript(#column: Int) -> Array<T> {
        get {
            assert(column >= 0 && column < columns, "Index out of range")
            var temp: [T] = []
            for row: Int in 0..<rows - 1 {
                temp.append(grid[row][column])
            }
            return temp
        }
        mutating set (newValue) {
            assert(column >= 0 && column < columns, "Index out of range")
            assert(newValue.count == columns, "New row has incorrect length")
            for row: Int in 0..<rows - 1 {
                grid[row][column] = newValue[row]
            }
        }
    }
}
