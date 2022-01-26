//
//  Scanner.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

class Scanner {
    
    static func scan(strategies: [ScannableStrategy]) {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        
        for index in 0..<typeCount {
            if let type = types[index] {
                for strategy in strategies {
                    if strategy.isMatched(anyClass: type) {
                        strategy.handle(anyClass: type)
                    }
                }
            }
        }
        types.deallocate()
    }
    
}
