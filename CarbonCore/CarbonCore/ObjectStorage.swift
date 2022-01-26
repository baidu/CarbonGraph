//
//  ObjectStorage.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

typealias StrongStorage = ObjectStorage

class ObjectStorage {
    var object: Any?
    func autorelease() {}
}

extension ObjectStorage: CustomStringConvertible {
    var description: String { String(describing: object) }
}

class WeakStorage: ObjectStorage {
    private struct Weak {
        private weak var object: AnyObject?
        var value: Any? {
            get { object }
            set { object = newValue as AnyObject? }
        }
    }
    
    private var _object = Weak()
    override var object: Any? {
        get { _object.value }
        set { _object.value = newValue }
    }
}

class AutoreleaseStorage: ObjectStorage {
    override func autorelease() {
        if object != nil {
            object = nil
        }
    }
}
