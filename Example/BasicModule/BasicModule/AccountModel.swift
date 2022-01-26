//
//  AccountModel.swift
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

@objc public class AccountModel: NSObject, AccountModelProtocol {
    
    @objc public let name: String
    @objc public let avatarImage: UIImage?
    @objc public let paymentType: PaymentType
    @objc public let certificationType: CertificationType
    
    @objc init(name: String = "",
         avatarImage: UIImage? = nil,
         paymentType: PaymentType = .normal,
         certificationType: CertificationType = .peraonal) {
        self.name = name
        self.avatarImage = avatarImage
        self.paymentType = paymentType
        self.certificationType = certificationType
        super.init()
    }
}
