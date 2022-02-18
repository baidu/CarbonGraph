//
//  AccountModelProtocol.swift
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

@objc public enum PaymentType: Int {
    case normal
    case vip
    case svip
}

@objc public enum CertificationType: Int {
    case peraonal
    case enterprise
    case government
    case school
    case media
}

@objc public protocol AccountModelProtocol: NSObjectProtocol {
    var name: String { get }
    var avatarImage: UIImage? { get }
    var paymentType: PaymentType { get }
    var certificationType: CertificationType { get }
}
