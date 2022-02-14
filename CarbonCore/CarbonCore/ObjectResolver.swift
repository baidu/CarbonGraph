//
//  ObjectResolver.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

/// A private class that exists for some historical reasons
///
/// - Note: It may be deleted at any time in the future, so don't use it directly.
public class ObjectResolver: NSObject {
    
    private weak var context: ObjectContext?
    
    /// A private method that exists for some historical reasons
    ///
    /// - Note: It may be deleted at any time in the future, so don't use it directly.
    @objc(initWithContext:) public init(_ context: ObjectContext) {
        self.context = context
    }
    
    func resolve<T, A>(
        _ key: ObjectKey,
        _ invoker: @escaping ((A) -> Any) -> Any
    ) -> T? {
        guard let context = self.context else { return nil }
        guard let def = (context.lock.read { context.objects[key] }) else {
            return nil
        }
        
        // Read singleton object
        if let safeObject = (def.lock.read { def.storage.object }),
           let singletonObject = safeObject as? T {
            return singletonObject
        }
        
        let errno = def.lock.write()
        defer {
            def.lock.unlock(errno)
        }
        
        // Object created by other thread
        if let safeObject = (def.lock.read { def.storage.object }),
           let otherObject = safeObject as? T {
            return otherObject
        }
        
        assert(errno != EDEADLK, "Recursive call may occur in factory or constructor!")
        
        // Create object
        var object: Any
        if let constructor = def.constructor as? (A) -> Any? {
            let constructedObject = invoker(constructor)
            
            /**
             In some models (iPhone SE / iPhone SE2), the following test code
             will execute case 2 (Can not unwraps double optionals with type
             conversion).
             
             This will cause the resolved object to return nil because the type
             can not be matched. So here temporarily use mirror to unwrap it 
             manually.
             
             Test Code:
             
             let anyOptional: Any? = invoker(factory)
             print(anyOptional as Any)
             // Optional(Optional(<UIViewController: 0x00>))
             if let anyOptional = anyOptional as? ViewControllerProtocol {
                 print(anyOptional)
                 // Case 1: <UIViewController: 0x00>
             } else {
                 print(anyOptional!)
                 // Case 2: Optional(<UIViewController: 0x00>)
             }
             
             Test Code Context:
             
             protocol ViewControllerProtocol {}
             extension UIViewController: ViewControllerProtocol {}
             
             func invoker(_ factory: () -> Any) -> Any { factory() }
             func factory() -> Any? { return UIViewController() }
             */
            
            let mirror = Mirror(reflecting: constructedObject)
            if mirror.displayStyle == .optional {
                if let value = mirror.children.first?.value {
                    object = value
                } else {
                    return nil
                }
            } else {
                object = constructedObject
            }
        } else if let factory = def.factory as? (A) -> Any {
            object = invoker(factory)
        } else if let cls = def.cls {
            object = cls.init()
        } else {
            return nil
        }
        guard let newObject = object as? T else {
            return nil
        }
        /**
         // When T is of type NSObjectProtocol.self
         
         Test Code:
         
         let nilObject: Any? = nil
         let a = nilObject as? NSObjectProtocol
         print("a:", a, type(of: a))
         // a: nil Optional<NSObject>
         let b = nilObject as? T
         print("b:", b, type(of: b))
         // b: Optional(<null>) Optional<NSObject>
         */
        guard !(newObject is NSNull) else {
            return nil
        }
        
        // Object created by factory or constructor
        if let safeObject = (def.lock.read { def.storage.object }),
           let otherObject = safeObject as? T {
            return otherObject
        }
        
        // Store object
        def.storage.object = newObject
        
        // Autowiring properties and setters
        autowiredProperties(def.propertiesName, of: newObject)
        unitedPropertySetter(def)(context, newObject as AnyObject)
        unitedSetter(def)(context, newObject)
        unitedAction(def)(context, newObject)
        
        // Release object if necessary
        def.storage.autorelease()
        
        return newObject
    }
    
    /// A private method that exists for some historical reasons
    ///
    /// - Note: It may be deleted at any time in the future, so don't use it directly.
    @objc public func autowiredProperties(
        protocol: Protocol, name: String?, of object: NSObject
    ) {
        guard let context = self.context else { return }
        let key = ObjectKey(`protocol`, name)
        guard let def = (context.lock.read { context.objects[key] }) else {
            return
        }
        autowiredProperties(def.propertiesName, of: object)
    }
    
    /// A private method that exists for some historical reasons
    ///
    /// - Note: It may be deleted at any time in the future, so don't use it directly.
    @objc public func autowiredProperty(_ propertyName: String,
                                        of object: NSObject) {
        guard let context = self.context else { return }
        
        if let property = class_getProperty(type(of: object), propertyName),
           let pattributes = property_getAttributes(property),
           let attributes = NSString(cString: pattributes,
                                     encoding: String.Encoding.ascii.rawValue) {
            let startRange = attributes.range(of: "T@\"")
            if startRange.location == NSNotFound {
                return
            }
            let startOfClassName = NSString(string: attributes.substring(from: startRange.length))
            let endRange = startOfClassName.range(of: "\"")
            if endRange.location == NSNotFound {
                return
            }
            
            var classOrProtocolName = startOfClassName.substring(to: endRange.location)
            var value: NSObject? = nil
            if classOrProtocolName.hasPrefix("<") &&
                classOrProtocolName.hasSuffix(">") {
                classOrProtocolName.removeFirst()
                classOrProtocolName.removeLast()
                guard let `protocol` = objc_getProtocol(classOrProtocolName) else {
                    return
                }
                value = context[`protocol`]
            } else if let cls = NSClassFromString(classOrProtocolName) as? NSObject.Type {
                value = cls.init()
            }
            guard let aValue = value else {
                return
            }
            if object.value(forKey: propertyName) == nil {
                object.setValue(aValue, forKey: propertyName)
            }
        }
    }
    
    private func unitedPropertySetter(_ def: ObjectDefinition) -> ((ObjectContext, AnyObject) -> Void) {
        guard !(def.properties?.isEmpty ?? true) else { return {_, _ in} }
        return { context, object in
            def.properties?.forEach { $0(context, object) }
        }
    }
    
    private func unitedSetter(_ def: ObjectDefinition) -> ((ObjectContext, Any) -> Void) {
        guard !(def.setters?.isEmpty ?? true) else { return {_, _ in} }
        return { context, object in
            def.setters?.forEach { $0(context, object) }
        }
    }
    
    private func unitedAction(_ def: ObjectDefinition) -> ((ObjectContext, Any) -> Void) {
        guard !(def.actions?.isEmpty ?? true) else { return {_, _ in} }
        return { context, object in
            def.actions?.forEach { $0(context, object) }
        }
    }
    
    private func autowiredProperties<T>(_ propertiesName: [String]?, of object: T) {
        if let object = object as? NSObject,
           let propertiesName = propertiesName {
            for propertyName in propertiesName {
                autowiredProperty(propertyName, of: object)
            }
        }
    }
}

extension ObjectResolver {
    public override var description: String {
        return "\(super.description.dropLast()); context: \(String(describing: context))"
    }
}
