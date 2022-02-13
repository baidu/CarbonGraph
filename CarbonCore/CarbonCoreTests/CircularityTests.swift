//
//  CircularityTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

public protocol ParentProtocol: AnyObject {}
public protocol ChildProtocol: AnyObject {}

public class Parent: ParentProtocol {
    var child: ChildProtocol?
    
    init() {}
    
    init(child: ChildProtocol) {
        self.child = child
    }
}

public class Child: ChildProtocol {
    weak var parent: ParentProtocol?
    
    init() {}
    
    init(parent: ParentProtocol) {
        self.parent = parent
    }
}

public protocol ProtocolA: AnyObject {}
public protocol ProtocolB: AnyObject {}
public protocol ProtocolC: AnyObject {}
public protocol ProtocolD: AnyObject {}

public class ADependingOnB: ProtocolA {
    var b: ProtocolB?
    
    init() {}
}

public class BDependingOnC: ProtocolB {
    var c: ProtocolC?
    
    init() {}
}

typealias CDependingNothing = CDependingOnAD
public class CDependingOnAD: ProtocolC {
    weak var a: ProtocolA?
    var d: ProtocolD?
    
    init() {}
    
    init(a: ProtocolA) {
        self.a = a
    }
}

public class DDependingOnBC: ProtocolD {
    weak var b: ProtocolB?
    weak var c: ProtocolC?
    
    init() {}
    
    init(b: ProtocolB, c: ProtocolC) {
        self.b = b
        self.c = c
    }
}

public class CDependingOnWeakB: ProtocolC {
    weak var b: ProtocolB?
}

