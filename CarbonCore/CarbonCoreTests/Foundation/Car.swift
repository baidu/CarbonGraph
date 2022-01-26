//
//  Car.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

@objc class Body: NSObject {
    @objc var color: String?
}

@objc class Brand: NSObject {
    @objc var name: String?
}

@objc class Car: NSObject {
    @objc var body: Body?
    @objc var brand: Brand?
}
