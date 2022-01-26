//
//  DefinitionBuilder.Args.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

extension FactoryDefinitionBuilder {
    
    /// Set the factory (with 1 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 1 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A>(
        _ f: @escaping (ObjectContext, A) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs(A.self).storeFactory(f)
    }
    
    /// Set the factory (with 2 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 2 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B>(
        _ f: @escaping (ObjectContext, A, B) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B).self).storeFactory(f)
    }
    
    /// Set the factory (with 3 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 3 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C>(
        _ f: @escaping (ObjectContext, A, B, C) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C).self).storeFactory(f)
    }
    
    /// Set the factory (with 4 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 4 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D>(
        _ f: @escaping (ObjectContext, A, B, C, D) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D).self).storeFactory(f)
    }
    
    /// Set the factory (with 5 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d, e in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d, e]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d, e] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 5 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D, E>(
        _ f: @escaping (ObjectContext, A, B, C, D, E) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D, E).self).storeFactory(f)
    }
    
    /// Set the factory (with 6 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d, e, f in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d, e, f]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d, e, f] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 6 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D, E, F>(
        _ f: @escaping (ObjectContext, A, B, C, D, E, F) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D, E, F).self).storeFactory(f)
    }
    
    /// Set the factory (with 7 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d, e, f, g in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d, e, f, g]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d, e, f, g] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 7 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D, E, F, G>(
        _ f: @escaping (ObjectContext, A, B, C, D, E, F, G) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D, E, F, G).self).storeFactory(f)
    }
    
    /// Set the factory (with 8 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d, e, f, g, h in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d, e, f, g, h]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d, e, f, g, h] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 8 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D, E, F, G, H>(
        _ f: @escaping (ObjectContext, A, B, C, D, E, F, G, H) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D, E, F, G, H).self).storeFactory(f)
    }
    
    /// Set the factory (with 9 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d, e, f, g, h, i in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d, e, f, g, h, i]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d, e, f, g, h, i] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 9 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D, E, F, G, H, I>(
        _ f: @escaping (ObjectContext, A, B, C, D, E, F, G, H, I) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D, E, F, G, H, I).self).storeFactory(f)
    }
    
    /// Set the factory (with 10 parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context, a, b, c, d, e, f, g, h, i, j in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [a, b, c, d, e, f, g, h, i, j]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self] // Automatic adaptation parameters
    /// context[MainVC.self, a, b, c, d, e, f, g, h, i, j] // Manually pass parameters
    /// ```
    ///
    /// - Parameter f: Factory (with 10 parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T, A, B, C, D, E, F, G, H, I, J>(
        _ f: @escaping (ObjectContext, A, B, C, D, E, F, G, H, I, J) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeArgs((A, B, C, D, E, F, G, H, I, J).self).storeFactory(f)
    }
    
}

extension FactoryDefinitionBuilder {
    
    /// Set the constructor (with 1 parameter) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 1 parameter) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A>(
        _ constructor: @escaping (A) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            return constructor(a)
        }
        return factory { _, a in
            constructor(a)
        }
    }
    
    /// Set the constructor (with 2 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 2 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B>(
        _ constructor: @escaping (A, B) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            return constructor(a, b)
        }
        return factory { _, a, b in
            constructor(a, b)
        }
    }
    
    /// Set the constructor (with 3 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 3 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C>(
        _ constructor: @escaping (A, B, C) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            return constructor(a, b, c)
        }
        return factory { _, a, b, c in
            constructor(a, b, c)
        }
    }
    
    /// Set the constructor (with 4 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 4 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D>(
        _ constructor: @escaping (A, B, C, D) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            return constructor(a, b, c, d)
        }
        return factory { _, a, b, c, d in
            constructor(a, b, c, d)
        }
    }
    
    /// Set the constructor (with 5 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:e:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d, e] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 5 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D, E>(
        _ constructor: @escaping (A, B, C, D, E) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            guard let e = $0[E.self] else { return nil }
            return constructor(a, b, c, d, e)
        }
        return factory { _, a, b, c, d, e in
            constructor(a, b, c, d, e)
        }
    }
    
    /// Set the constructor (with 6 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:e:f:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d, e, f] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 6 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D, E, F>(
        _ constructor: @escaping (A, B, C, D, E, F) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            guard let e = $0[E.self] else { return nil }
            guard let f = $0[F.self] else { return nil }
            return constructor(a, b, c, d, e, f)
        }
        return factory { _, a, b, c, d, e, f in
            constructor(a, b, c, d, e, f)
        }
    }
    
    /// Set the constructor (with 7 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:e:f:g:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d, e, f, g] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 7 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D, E, F, G>(
        _ constructor: @escaping (A, B, C, D, E, F, G) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            guard let e = $0[E.self] else { return nil }
            guard let f = $0[F.self] else { return nil }
            guard let g = $0[G.self] else { return nil }
            return constructor(a, b, c, d, e, f, g)
        }
        return factory { _, a, b, c, d, e, f, g in
            constructor(a, b, c, d, e, f, g)
        }
    }
    
    /// Set the constructor (with 8 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:e:f:g:h:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d, e, f, g, h] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 8 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D, E, F, G, H>(
        _ constructor: @escaping (A, B, C, D, E, F, G, H) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            guard let e = $0[E.self] else { return nil }
            guard let f = $0[F.self] else { return nil }
            guard let g = $0[G.self] else { return nil }
            guard let h = $0[H.self] else { return nil }
            return constructor(a, b, c, d, e, f, g, h)
        }
        return factory { _, a, b, c, d, e, f, g, h in
            constructor(a, b, c, d, e, f, g, h)
        }
    }
    
    /// Set the constructor (with 9 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:e:f:g:h:i:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d, e, f, g, h, i] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 9 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D, E, F, G, H, I>(
        _ constructor: @escaping (A, B, C, D, E, F, G, H, I) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            guard let e = $0[E.self] else { return nil }
            guard let f = $0[F.self] else { return nil }
            guard let g = $0[G.self] else { return nil }
            guard let h = $0[H.self] else { return nil }
            guard let i = $0[I.self] else { return nil }
            return constructor(a, b, c, d, e, f, g, h, i)
        }
        return factory { _, a, b, c, d, e, f, g, h, i in
            constructor(a, b, c, d, e, f, g, h, i)
        }
    }
    
    /// Set the constructor (with 10 parameters) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(
    ///     PetOwner.init(a:b:c:d:e:f:g:h:i:j:)
    /// )
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self] // Automatic adaptation parameters
    /// context[PetOwner.self, a, b, c, d, e, f, g, h, i, j] // Manually pass parameters
    /// ```
    ///
    /// - Parameter constructor: Constructor (with 10 parameters) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T, A, B, C, D, E, F, G, H, I, J>(
        _ constructor: @escaping (A, B, C, D, E, F, G, H, I, J) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeConstructor {
            guard let a = $0[A.self] else { return nil }
            guard let b = $0[B.self] else { return nil }
            guard let c = $0[C.self] else { return nil }
            guard let d = $0[D.self] else { return nil }
            guard let e = $0[E.self] else { return nil }
            guard let f = $0[F.self] else { return nil }
            guard let g = $0[G.self] else { return nil }
            guard let h = $0[H.self] else { return nil }
            guard let i = $0[I.self] else { return nil }
            guard let j = $0[J.self] else { return nil }
            return constructor(a, b, c, d, e, f, g, h, i, j)
        }
        return factory { _, a, b, c, d, e, f, g, h, i, j in
            constructor(a, b, c, d, e, f, g, h, i, j)
        }
    }
    
}

extension AutowiredDefinitionBuilder {
    
    /// Set the setter method (with 1 parameter) of the object to make the framework to automatically
    /// inject dependency through method parameter
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 1 parameter) of the object to make the framework
    /// to automatically inject dependency through method parameter
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A>(
        _ setter: @escaping (T) -> ((A) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            setter(obj)(a)
        }
    }
    
    /// Set the setter method (with 2 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 2 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B>(
        _ setter: @escaping (T) -> ((A, B) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            setter(obj)(a, b)
        }
    }
    
    /// Set the setter method (with 3 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 3 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C>(
        _ setter: @escaping (T) -> ((A, B, C) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            setter(obj)(a, b, c)
        }
    }
    
    /// Set the setter method (with 4 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 4 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D>(
        _ setter: @escaping (T) -> ((A, B, C, D) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            setter(obj)(a, b, c, d)
        }
    }
    
    /// Set the setter method (with 5 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:e:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 5 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D, E>(
        _ setter: @escaping (T) -> ((A, B, C, D, E) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            guard let e = $0[E.self] else { return }
            setter(obj)(a, b, c, d, e)
        }
    }
    
    /// Set the setter method (with 6 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:e:f:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 6 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D, E, F>(
        _ setter: @escaping (T) -> ((A, B, C, D, E, F) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            guard let e = $0[E.self] else { return }
            guard let f = $0[F.self] else { return }
            setter(obj)(a, b, c, d, e, f)
        }
    }
    
    /// Set the setter method (with 7 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:e:f:g:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 7 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D, E, F, G>(
        _ setter: @escaping (T) -> ((A, B, C, D, E, F, G) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            guard let e = $0[E.self] else { return }
            guard let f = $0[F.self] else { return }
            guard let g = $0[G.self] else { return }
            setter(obj)(a, b, c, d, e, f, g)
        }
    }
    
    /// Set the setter method (with 8 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:e:f:g:h:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 8 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D, E, F, G, H>(
        _ setter: @escaping (T) -> ((A, B, C, D, E, F, G, H) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            guard let e = $0[E.self] else { return }
            guard let f = $0[F.self] else { return }
            guard let g = $0[G.self] else { return }
            guard let h = $0[H.self] else { return }
            setter(obj)(a, b, c, d, e, f, g, h)
        }
    }
    
    /// Set the setter method (with 9 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:e:f:g:h:i:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 9 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D, E, F, G, H, I>(
        _ setter: @escaping (T) -> ((A, B, C, D, E, F, G, H, I) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            guard let e = $0[E.self] else { return }
            guard let f = $0[F.self] else { return }
            guard let g = $0[G.self] else { return }
            guard let h = $0[H.self] else { return }
            guard let i = $0[I.self] else { return }
            setter(obj)(a, b, c, d, e, f, g, h, i)
        }
    }
    
    /// Set the setter method (with 10 parameters) of the object to make the framework to automatically
    /// inject dependencies through method parameters
    ///
    /// The setter method is not actually a setter method, but the method that can obtained the
    /// object's setter method by pass the object. You can get such method from the type, for example:
    /// The `viewWithTag(_:)` method of UIView is `(Int) -> UIView?` type.
    /// Using `UIView.viewWithTag(_:)` will return the method of
    /// `(UIView) -> (Int) -> UIView?` type.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .object(PetOwner())
    ///     .setter(PetOwner.setup(a:b:c:d:e:f:g:h:i:j:))
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// Only support reference types.
    ///
    /// - Parameter keyPath: Setter method (with 10 parameters) of the object to make the framework
    /// to automatically inject dependencies through method parameters
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func setter<A, B, C, D, E, F, G, H, I, J>(
        _ setter: @escaping (T) -> ((A, B, C, D, E, F, G, H, I, J) -> Void)
    ) -> AutowiredDefinitionBuilder<T> {
        return storeSetter {
            guard let obj = $1 as? T else { return }
            guard let a = $0[A.self] else { return }
            guard let b = $0[B.self] else { return }
            guard let c = $0[C.self] else { return }
            guard let d = $0[D.self] else { return }
            guard let e = $0[E.self] else { return }
            guard let f = $0[F.self] else { return }
            guard let g = $0[G.self] else { return }
            guard let h = $0[H.self] else { return }
            guard let i = $0[I.self] else { return }
            guard let j = $0[J.self] else { return }
            setter(obj)(a, b, c, d, e, f, g, h, i, j)
        }
    }
    
}
