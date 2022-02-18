//
//  ObjectContext.Args.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

extension ObjectContext {
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg: The constructor or factory's only argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A>(
        _: T.Type,
        arg: A,
        name name: String? = nil
    ) -> T? {
        resolve(name, A.self) {
            $0((self, arg))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B>(
        _: T.Type,
        arg1: A, arg2: B,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B).self) {
            $0((self, arg1, arg2))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C).self) {
            $0((self, arg1, arg2, arg3))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D).self) {
            $0((self, arg1, arg2, arg3, arg4))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - arg5: The constructor or factory's 5th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D, E>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D, arg5: E,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D, E).self) {
            $0((self, arg1, arg2, arg3, arg4, arg5))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - arg5: The constructor or factory's 5th argument of the object definition
    ///   - arg6: The constructor or factory's 6th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D, E, F>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D, arg5: E, arg6: F,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D, E, F).self) {
            $0((self, arg1, arg2, arg3, arg4, arg5, arg6))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - arg5: The constructor or factory's 5th argument of the object definition
    ///   - arg6: The constructor or factory's 6th argument of the object definition
    ///   - arg7: The constructor or factory's 7th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D, E, F, G>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D, arg5: E, arg6: F, arg7: G,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D, E, F, G).self) {
            $0((self, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - arg5: The constructor or factory's 5th argument of the object definition
    ///   - arg6: The constructor or factory's 6th argument of the object definition
    ///   - arg7: The constructor or factory's 7th argument of the object definition
    ///   - arg8: The constructor or factory's 8th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D, E, F, G, H>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D, arg5: E, arg6: F, arg7: G, arg8: H,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D, E, F, G, H).self) {
            $0((self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - arg5: The constructor or factory's 5th argument of the object definition
    ///   - arg6: The constructor or factory's 6th argument of the object definition
    ///   - arg7: The constructor or factory's 7th argument of the object definition
    ///   - arg8: The constructor or factory's 8th argument of the object definition
    ///   - arg9: The constructor or factory's 9th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D, E, F, G, H, I>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D, arg5: E, arg6: F, arg7: G, arg8: H, arg9: I,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D, E, F, G, H, I).self) {
            $0((self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))
        }
    }
    
    /// Resolve the object by type and custom argument of constructor or factory
    ///
    /// - Parameters:
    ///   - \_: Type of object definition
    ///   - arg1: The constructor or factory's 1st argument of the object definition
    ///   - arg2: The constructor or factory's 2nd argument of the object definition
    ///   - arg3: The constructor or factory's 3rd argument of the object definition
    ///   - arg4: The constructor or factory's 4th argument of the object definition
    ///   - arg5: The constructor or factory's 5th argument of the object definition
    ///   - arg6: The constructor or factory's 6th argument of the object definition
    ///   - arg7: The constructor or factory's 7th argument of the object definition
    ///   - arg8: The constructor or factory's 8th argument of the object definition
    ///   - arg9: The constructor or factory's 9th argument of the object definition
    ///   - arg10: The constructor or factory's 10th argument of the object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    public subscript<T, A, B, C, D, E, F, G, H, I, J>(
        _: T.Type,
        arg1: A, arg2: B, arg3: C, arg4: D, arg5: E, arg6: F, arg7: G, arg8: H, arg9: I, arg10: J,
        name name: String? = nil
    ) -> T? {
        resolve(name, (A, B, C, D, E, F, G, H, I, J).self) {
            $0((self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10))
        }
    }
    
}
