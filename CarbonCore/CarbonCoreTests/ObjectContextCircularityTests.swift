//
//  ObjectContextCircularityTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextCircularityTests: XCTestCase {
    
    var context: ApplicationContext!
    override func setUpWithError() throws {
        context = ApplicationContext()
    }
    
    func testObjectContextResolvesCircularEachDependencyProperty() {
        context.clean()
        
        let parentBuilder = Definition()
            .protocol(ParentProtocol.self)
            .object(Parent())
            .property(\.child)
        
        let childBuilder = Definition()
            .protocol(ChildProtocol.self)
            .object(Child())
            .property(\.parent)
        
        context.register(builder: parentBuilder)
        context.register(builder: childBuilder)
        
        let parent = context[ParentProtocol.self] as! Parent
        let childParent = (parent.child as! Child).parent
        XCTAssertIdentical(parent, childParent)
    }
    
    func testObjectContextResolvesCircularDependencyOnConstructorAndProperty() {
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
        
        let parent = context[ParentProtocol.self] as! Parent
        let childParent = (parent.child as! Child).parent
        XCTAssertIdentical(parent, childParent)
    }
    
    func testObjectContextResolvesCircularDependencyOnConstructor() {
        context.clean()
        
        let parentBuilder = Definition()
            .protocol(ParentProtocol.self)
            .constructor(Parent.init(child:))
        
        let childBuilder = Definition()
            .protocol(ChildProtocol.self)
            .constructor(Child.init(parent:))
        
        context.register(builder: parentBuilder)
        context.register(builder: childBuilder)
        
        // context[ParentProtocol.self] will trigger the assertion
        // Assertion methods can not be unit tested
    }
    
    func testObjectContextResolvesCircularDependencyOnProperties() {
        let aBuilder = Definition()
            .protocol(ProtocolA.self)
            .object(ADependingOnB())
            .property(\.b)
        
        let bBuilder = Definition()
            .protocol(ProtocolB.self)
            .object(BDependingOnC())
            .property(\.c)
        
        let cBuilder = Definition()
            .protocol(ProtocolC.self)
            .object(CDependingOnAD())
            .property(\.a)
            .property(\.d)
        
        let dBuilder = Definition()
            .protocol(ProtocolD.self)
            .object(DDependingOnBC())
            .property(\.b)
            .property(\.c)
        
        context.register(builder: aBuilder)
        context.register(builder: bBuilder)
        context.register(builder: cBuilder)
        context.register(builder: dBuilder)
        
        let a = context[ProtocolA.self] as! ADependingOnB
        let b = a.b as! BDependingOnC
        let c = b.c as! CDependingOnAD
        let d = c.d as! DDependingOnBC
        XCTAssertIdentical(c.a as? ADependingOnB, a)
        XCTAssertIdentical(d.b as? BDependingOnC, b)
        XCTAssertIdentical(d.c as? CDependingOnAD, c)
    }
    
    func testObjectContextResolvesCircularDependencyOnConstructorAndProperties() {
        let aBuilder = Definition()
            .protocol(ProtocolA.self)
            .object(ADependingOnB())
            .property(\.b)
        
        let bBuilder = Definition()
            .protocol(ProtocolB.self)
            .object(BDependingOnC())
            .property(\.c)
        
        let cBuilder = Definition()
            .protocol(ProtocolC.self)
            .constructor(CDependingOnAD.init(a:))
            .property(\.d)
        
        let dBuilder = Definition()
            .protocol(ProtocolD.self)
            .constructor(DDependingOnBC.init(b:c:))
        
        context.register(builder: aBuilder)
        context.register(builder: bBuilder)
        context.register(builder: cBuilder)
        context.register(builder: dBuilder)
        
        let a = context[ProtocolA.self] as! ADependingOnB
        let b = a.b as! BDependingOnC
        let c = b.c as! CDependingOnAD
        let d = c.d as! DDependingOnBC
        XCTAssertIdentical(c.a as? ADependingOnB, a)
        XCTAssertIdentical(d.b as? BDependingOnC, b)
        XCTAssertIdentical(d.c as? CDependingOnAD, c)
    }
    
}

