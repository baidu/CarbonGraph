//
//  ScannerStrategy.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation
import UIKit

/// Strategy used to collect classes
///
/// Override matching and processing methods to implement custom collection behaviors
@objc(CBNScannableStrategy) public protocol ScannableStrategy {
    
    @objc init()
    
    /// Collected types
    @objc var types: [AnyClass] { get set }
    
    /// Matching method
    @objc func isMatched(anyClass: AnyClass) -> Bool
    
    /// Processing method
    @objc func handle(anyClass: AnyClass)
    
}
