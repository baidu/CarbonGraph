//
//  Person.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

protocol Person: Animal {}

class PetOwner: NSObject, OCProtocol, OCAliasProtocol, OCAliasOtherProtocol, Person {
    var name: String?
    
    var pet: Animal
    var favoriteFood: Food?
    
    override init() {
        self.pet = Dog()
        super.init()
    }
    
    init(pet: Animal) {
        self.pet = pet
    }
    
    func injectAnimal(_ animal: Animal) {
        pet = animal
    }
}

class Engineer: NSObject, OCProtocol, OCAliasProtocol, OCAliasOtherProtocol, Person {
    var name: String?

    var favoriteFood: Food?
}

