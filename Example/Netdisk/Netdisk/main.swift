//
//  main.swift
//  Netdisk
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit
import CarbonObjC
import AppDelegateModule

UIApplicationMain(
    CommandLine.argc, CommandLine.unsafeArgv,
    NSStringFromClass(CBNApplication.self),
    NSStringFromClass(AppDelegate.self)
)
