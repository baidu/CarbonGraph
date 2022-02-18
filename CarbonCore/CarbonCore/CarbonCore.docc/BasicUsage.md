# Basic usage

Object registration and resolving.

## Overview

* Basic object registration and resolving
```swift
let context = ObjectContext()
context.register(builder: Definition().object(FileViewController()))
context[FileViewController.self]
```

* Use configuration batch registration
```swift
class MyConfiguration: ScannableObject, Configuration {
    static func definitions() -> Definitions {
        Definition()
            .object(FilePath())
        Definition()
            .constructor(FileModel.init(filePath:))
    }
}

let context = ObjectContext()
context.register(configuration: MyConfiguration.self)
context[FileModel.self]
```

> Note: For convenience, the registration of object definitions and the creation of context that appear in the following will be omitted. All definitions in your project must be registered before they can be resolved.

### Object Scope

* default: Default object life cycle, alias of prototype
* prototype: Local object life cycle
* singleton: Singleton object life cycle
* weakSingleton: Weak reference singleton object life cycle

```swift
Definition()
    .protocol(FileManagerProtocol.self)
    .object(FileManager())
    .scope(.singleton)
```

* Multiple object definition methods
```swift
Definition().object(FilePath())
Definition().constructor(FilePath.init)
Definition().factory { _ in FilePath() }
context[FileModel.self]
```

* Define protocol alias for object
```swift
Definition()
    .object(FileModel(path: "/") as FileModelProtocol)
context[FileModelProtocol.self]
```
The same as:
```swift
Definition()
    .protocol(FileModelProtocol.self)
    .object(FileModel(path: "/"))
```

* Define multiple protocol aliases for the object
```swift
Definition()
    .protocol(FileManagerProtocol.self)
    .alias(ImageManagerProtocol.self)
    .alias(DirectoryManagerProtocol.self)
    .object(FileManager())
context[FileManagerProtocol.self]
context[ImageManagerProtocol.self]
context[DirectoryManagerProtocol.self]
```
The same as:
```swift
Definition()
    .protocol(FileManagerProtocol.self)
    .alias([ImageManagerProtocol.self, DirectoryManagerProtocol.self])
    .object(FileManager())
```

* Use constructor for dependency injection
```swift
Definition()
    .protocol(FileViewControllerProtocol.self)
    .constructor(FileViewController.init(fileManager:))
context[FileViewControllerProtocol.self].fileManager
```

* Use property for dependency injection
```swift
Definition()
    .protocol(FileViewControllerProtocol.self)
    .object(FileViewController())
    .property(\.fileManager)
context[FileViewControllerProtocol.self].fileManager
```

* Use setter for dependency injection
```swift
Definition()
    .protocol(FileViewControllerProtocol.self)
    .object(FileViewController())
    .setter(FileViewController.setFileManager)
context[FileViewControllerProtocol.self].fileManager
```

* Use static factory for manual dependency injection
```swift
Definition()
    .factory(fileViewController(context:))
context[FileViewControllerProtocol.self].fileManager

static func fileViewController(context: ObjectContext) -> FileViewControllerProtocol {
    let fileVC = FileViewController()
    fileVC.fileManager = context[FileManagerProtocol]
    return fileVC
}
```
The same as:
```swift
Definition()
    .factory { context in 
        let fileVC = FileViewController()
        fileVC.fileManager = context[FileManagerProtocol]
        return fileVC as FileViewControllerProtocol
    }
```

* Create objects with external parameters
```swift
Definition()
    .factory(fileModel(context:path:name:))
context[FileModelProtocol.self, "/china/beijing", "family.png"]

static func fileModel(context: ObjectContext, path: String, name: String) -> FileModelProtocol {
    FileModel(path: path, name: name)
}
```

## Topics

### Convenience registration

- ``ObjectContext/register(protocol:cls:name:)``

- ``ObjectContext/register(protocol:object:name:)``

### Context

- ``ObjectContext``

- ``ObjectScope``

### DSL Syntax

- ``DefinitionBuilder``

- ``Configuration``

## See Also

- <doc:AdvancedUsage>

- <doc:ModuleManagement>
