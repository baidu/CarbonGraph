//
//  AnimalKeeper.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

protocol AnimalKeeper {
    var animal: Animal { get set }
    static func forbiddenBreed() -> [String]
}

struct CatKeeper: AnimalKeeper {
    var animal: Animal
    static func forbiddenBreed() -> [String] {
        return ["Maine Coon"]
    }
}

struct DogKeeper: AnimalKeeper {
    var animal: Animal
    static func forbiddenBreed() -> [String] {
        return ["Bernese Mountain"]
    }
}
