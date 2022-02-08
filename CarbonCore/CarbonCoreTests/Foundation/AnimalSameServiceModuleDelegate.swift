//
//  AnimalSameServiceModuleDelegate.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation
import CarbonCore

class AnimalSameServiceModuleDelegate: ScannableModuleConfiguration {
    
    static func definitions(of context: ObjectContext) -> Definitions {
        Definition()
            .protocol(Animal.self)
            .constructor(
                Cat.init(name:)
            )
        
        Definition()
            .protocol(Animal.self)
            .constructor(
                Cat.init(name:sleeping:)
            )
        
        Definition()
            .constructor(
                Cat.init(name:sleeping:)
            )
        
        Definition()
            .factory(catModel(context:arg1:arg2:))
        
        Definition()
            .protocol(Person.self)
            .factory { _ in
                PetOwner()
            }
            .property(\.pet)
            .property(\.favoriteFood)
        
        Definition()
            .protocol(Animal.self)
            .factory { _, arg in
                Cat(name: arg)
            }
        
        Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }.property(\.favoriteFood)
        
        Definition()
            .protocol(Food.self)
            .factory { _ in
                Sushi()
            }.scope(ObjectScope.prototype)
        
        Definition()
            .protocol(Cat.self)
            .factory { _ in
                Cat()
            }.property(\.favoriteFood)
    }
    
    static func launchOptions() -> [ModuleLaunchOptionsItem] {
        [.priority(.business)]
    }
    
    func moduleDidFinishLaunching(_ module: Module) {
        
    }
    
}

extension AnimalSameServiceModuleDelegate {
    static func catModel(context: ObjectContext, arg1: String, arg2: Bool) -> Cat {
        Cat(name: arg1, sleeping: arg2)
    }
}
