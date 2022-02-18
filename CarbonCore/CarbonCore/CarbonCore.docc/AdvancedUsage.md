# Advanced usage

Advanced usage and design of DSL

## Overview

### Design of DSL

DefinitionBuilder is a DSL Syntax used to build ObjectDefinition.
ObjectDefinition is the definition of the object and stores the data needed to resolve the object.

These data are divided into 4 types:
* Key: The unique identifier of the object definition, used to locate
* Factory: The closure used to create the object and the dependencies that need to be built during creation
* Autowired: Dependencies that need to be built after creation
* Configuration: Other configuration of the object

DefinitionBuilder has 10 subclasses. Each subclass is used to set a type of ObjectDefinition data.

Their corresponding relationship is as follows:
* Key: ``KeyDefinitionBuilder``, ``AliasDefinitionBuilder``, ``DynamicAliasDefinitionBuilder``
* Factory: ``FactoryDefinitionBuilder``, ``DynamicFactoryDefinitionBuilder``, ``DynamicClassDefinitionBuilder``
* Autowired: ``AutowiredDefinitionBuilder``, ``DynamicAutowiredDefinitionBuilder``
* Configuration: ``AttributeDefinitionBuilder``, ``ActionDefinitionBuilder``

The method of each DefinitionBuilder controls which methods can be used in the next step by controlling the returned DefinitionBuilder type. So you can only complete an ObjectDefinition in a set order. Each DefinitionBuilder controls which settings can be omitted by controlling the inheritance relationship.

The specifications are as follows, '>' means order, italics means it can be omitted. It doesn't matter if you are confused, the compiler will tell you the correct way.

* *Key* > *Alias* > Factory > *Autowired* > *Attribute* > *Action*
* Key > *DynamicAlias* > *DynamicFactory* > DynamicClass  > *DynamicAutowired* > *Attribute* > *Action*

### Circular dependency

During the life cycle of object creation, the creation of dependent objects will be temporarily stored. This design can solve most recursion caused by circular dependencies.

When there is a circular dependency, it is recommended that at least one object in the circular chain use property or setter injection to build dependencies, this will create dependent objects after the root object is created, using previously created object will break the loop.

In the following example, both parent and childParent have values and are the same object.

```swift
let parentBuilder = Definition()
    .protocol(ParentProtocol.self)
    .object(Parent())
    .property(\.child)
let childBuilder = Definition()
    .protocol(ChildProtocol.self)
    .object(Child())
    .property(\.parent)

context.register(builder: parentBuilder)
context.register(builder: childBuilder)

let parent = context[ParentProtocol.self] as! Parent
let childParent = (parent.child as! Child).parent
```
The same as:
```swift
let parentBuilder = Definition()
    .protocol(ParentProtocol.self)
    .object(Parent())
    .property(\.child)
let childBuilder = Definition()
    .protocol(ChildProtocol.self)
    .constructor(Child.init(parent:))
```

If the constructor is used to build dependencies, this will create dependent objects when the object creation is not completed, which will inevitably cause recursion.

In the following example, resolving ParentProtocol will trigger the dead lock assertion.

```swift
let parentBuilder = Definition()
    .protocol(ParentProtocol.self)
    .constructor(Parent.init(child:))

let childBuilder = Definition()
    .protocol(ChildProtocol.self)
    .constructor(Child.init(parent:))

context.register(builder: parentBuilder)
context.register(builder: childBuilder)
``` 

> Tips: If you must use the constructor to build dependencies, at least one object in the circular chain is a singleton, which also avoids recursion.

### Thread safety

Object resolving is thread-safe, but registration methods are currently not thread-safe, these methods will be marked in the interface comment - “Note: It's not thread-safe, do not use it in a multi-threaded environment.”

## Topics

### DSL Syntax

- ``DefinitionBuilder``

- ``GroupDefinitionBuilder``

- ``ConfigurationBuilder``

- ``Configuration``

## See Also

- <doc:ModuleManagement>
