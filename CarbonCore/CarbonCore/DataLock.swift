//
//  DataLock.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

final class DataLock {
    
    private var rwlock = pthread_rwlock_t()
    
    init() {
        pthread_rwlock_init(&rwlock, nil)
    }
    
    @discardableResult
    func read() -> Int32 {
        pthread_rwlock_rdlock(&rwlock)
    }
    
    @discardableResult
    func write() -> Int32 {
        pthread_rwlock_wrlock(&rwlock)
    }
    
    @discardableResult
    func unlock(_ errno: Int32 = 0) -> Int32 {
        if errno == 0 {
            return pthread_rwlock_unlock(&rwlock)
        } else {
            return errno
        }
    }
    
    @discardableResult
    func read<T>(_ action: () -> T) -> T {
        let errno = read()
        defer { unlock(errno) }
        return action()
    }
    
    func write(_ action: () -> Void) {
        let errno = write()
        defer { unlock(errno) }
        action()
    }
    
    deinit {
        pthread_rwlock_destroy(&rwlock)
    }
    
}
