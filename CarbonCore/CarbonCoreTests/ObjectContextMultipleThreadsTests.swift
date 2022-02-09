//
//  ObjectContextMultipleThreadsTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextMultipleThreadsTests: XCTestCase {
    var context: ApplicationContext!
    private let threadCount = 10000
    
    override func setUpWithError() throws {
        context = ApplicationContext(moduleScan: false)
    }
    
    func testMultipleThreadsRegister() {
        let expectation = self.expectation(description: "request should complete")
        expectation.expectedFulfillmentCount = threadCount
        context.clean()
        concurrentPerform {
            let builder = Definition(UUID().uuidString)
                .object(PetOwner() as Person)
            self.context.register(builder: builder)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(context.objects.count, threadCount)
    }
    
    func testMultipleThreadsResolver() {
        let expectation = self.expectation(description: "request should complete")
        expectation.expectedFulfillmentCount = threadCount
        context.clean()
        var persons = Set<PetOwner>()
        let builder = Definition()
            .object(persons.insert(PetOwner()).memberAfterInsert as Person)
        context.register(builder: builder)
        concurrentPerform {
            _ = self.context[Person.self]
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(persons.count, threadCount)
    }
    
    func testMultipleThreadsResolverCanMakeItWithoutDeadlock() {
        context.clean()
        let parentBuilder = Definition()
            .protocol(ParentProtocol.self)
            .object(Parent())
            .property(\.child)
        
        let childBuilder = Definition()
            .protocol(ChildProtocol.self)
            .constructor(Child.init(parent:))
        
        context.register(builder: parentBuilder)
        context.register(builder: childBuilder)
        
        concurrentPerform {
            _ = self.context[ParentProtocol.self]
        }
    }
    
    func testMultipleThreadsResolverPerformance() throws {
        context.clean()
        let definitionCount = 1000
        for i in 0..<definitionCount {
            let builder = Definition("\(i)").object(PetOwner())
            context.register(builder: builder)
        }
        measure {
            DispatchQueue.concurrentPerform(iterations: threadCount) { i in
                _ = self.context[PetOwner.self, name: "\(i % definitionCount)"]
            }
        }
    }
    
    private func concurrentPerform(operation: @escaping () -> Void) {
        let queue = DispatchQueue(
            label: "CarbonCoreTests_MultipleThreads_Queue",
            attributes: .concurrent
        )
        for _ in 0 ..< self.threadCount {
            queue.async {
                operation()
            }
        }
    }
}

