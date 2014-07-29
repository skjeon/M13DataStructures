//
//  M13DataStructuresTests.swift
//  M13DataStructuresTests
//
//  Created by Brandon McQuilkin on 7/27/14.
//  Copyright (c) 2014 BrandonMcQuilkin. All rights reserved.
//

import UIKit
import XCTest

class M13DataStructuresTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStackPushSingle() {
        var aStack: Stack<String> = Stack()
        aStack.push("A")
        XCTAssert(aStack.count == 1, "Stack: push single passed.")
    }
    
    func testStackPushArray() {
        var aStack: Stack<String> = Stack()
        aStack.push(["A", "B", "C"])
        XCTAssert(aStack.count == 3, "Stack: push array passed.")
    }
    
    func testStackPeek() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        XCTAssert(aStack.peek == "C", "Stack: peek passed")
    }
    
    func testStackPopSingle() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        aStack.pop()
        XCTAssert(aStack.peek == "B", "Stack: pop single passed")
    }
    
    func testStackPopMultiple() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        aStack.pop(2)
        XCTAssert(aStack.peek == "A", "Stack: pop multiple passed")
    }
    
    func testStackDropSingle() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        aStack.drop()
        XCTAssert(aStack.count == 2, "Stack: drop single passed")
    }
    
    func testStackDropMultiple() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        aStack.drop(2)
        XCTAssert(aStack.count == 1, "Stack: drop multiple passed")
    }
    
    func testStackGenerate() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        var aString = ""
        for temp in aStack {
            aString += temp
        }
        XCTAssert(aString == "CBA", "Stack: generate passed")
    }

    func testPlusEqualsSingle() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        aStack += "D"
        XCTAssert(aStack.peek == "D", "Stack: += single passed")
    }
   
    func testPlusEqualsStack() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        var bStack: Stack<String> = Stack(objects: ["D"])
        aStack += bStack
        XCTAssert(aStack.peek == "D", "Stack: += stack passed")
    }
    
    func testPlusEqualsArray() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        aStack += ["D", "E"]
        XCTAssert(aStack.peek == "E", "Stack: += array passed")
    }
    
    func testPlusSingle() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        var bStack = aStack + "D"
        XCTAssert(aStack.peek == "C" && bStack.peek == "D" && bStack.count == 4, "Stack: + single passed")
    }
    
    func testPlusStack() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        var bStack = aStack + Stack(objects: ["D"])
        XCTAssert(aStack.peek == "C" && bStack.peek == "D" && bStack.count == 4, "Stack: + stack passed")
    }
    
    func testPlusArray() {
        var aStack: Stack<String> = Stack(objects: ["A", "B", "C"])
        var bStack = aStack + ["D", "E"]
        XCTAssert(aStack.peek == "C" && bStack.peek == "E" && bStack.count == 5, "Stack: + array passed")
    }
}
