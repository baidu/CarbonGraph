# ``CarbonCore``

CarbonGraph is a Swift dependency injection / lookup framework for iOS. You can use it to build loose coupling between modules.

## Overview

![Logo Banner](logo_banner.png)

* Complete dependency injection capabilities  
* Complete Objective-C support  
* Convenient object definition DSL  
* High-performance thread-safe solution  
* Support resolving native Swift types  
* Support resolving with external parameters  
* Support resolving with circular dependencies  
* Automatic scanning of configuration  
* Additional module life cycle management capabilities 


The CarbonGraph project contains 2 frameworks, If only used in Swift, just import CarbonCore, otherwise import both.

| Framework | Description |
| --- | --- |
| CarbonCore | Focused specifically on core DI implementations |
| CarbonObjC | CarbonCore's ObjC adaptation framework |

## Quick Start

* Basic object registration and resolving
```swift
let context = ObjectContext()
let definitionBuilder = Definition("filevc")
    .protocol(UIViewController.self)
    .object(FileViewController())
context.register(builder: definitionBuilder)
context[UIViewController.self, name: "filevc"]
```

```swift
let context = ObjectContext()
let definitionBuilder = Definition()
    .object(FileManager() as FileManagerProtocol)
context.register(builder: definitionBuilder)
context[FileManagerProtocol.self]
```

* Use configuration batch registration
```swift
class MyConfiguration: Configuration {
    static func definitions(of context: ObjectContext) -> Definitions {
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
