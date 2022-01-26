//
//  FileModelProtocol.swift
//  FileModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

@objc public protocol FileModelProtocol: NSObjectProtocol {
    var filePath: String { get set }
    var fileName: String { get set }
}
