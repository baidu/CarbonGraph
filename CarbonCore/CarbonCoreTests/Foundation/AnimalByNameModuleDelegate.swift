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

class AnimalByNameModuleDelegate: ScannableModuleConfiguration {
    
    static func definitions(of context: ObjectContext) -> Definitions {
        Definition("MyPersian")
            .protocol(Animal.self)
            .factory { _, arg in
                Cat(name: arg)
            }
        
        Definition("MyScottishFold")
            .protocol(Animal.self)
            .factory { _, arg in
                Cat(name: arg)
            }
        
        Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }
    }
    
    static func launchOptions() -> [ModuleLaunchOptionsItem] {
        [ModuleLaunchOptionsItem(priority: .business)]
    }
    
    func moduleDidFinishLaunching(_ module: Module) {
        
    }
}
