//
//  Animal.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

protocol Animal {
    var name: String? { get set }
}

@objc class Cat: NSObject, Animal {
    var name: String?
    var sleeping = false
    var favoriteFood: Food?
    
    deinit {
        print("deinit")
    }
    
    override init() {}
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, sleeping: Bool) {
        self.name = name
        self.sleeping = sleeping
    }
}

class Persian: Cat {}

class Dog: Animal {
    var name: String?
    init() {}
    
    init(name: String) {
        self.name = name
    }
}

class Pig: Animal {
    var name: String?
    
    init() {}
    
    init(name: String) {
        self.name = name
    }
    
    init(name1: String, name2: String) {
        self.name = name1
    }
}

struct Turtle: Animal {
    var name: String?
}
