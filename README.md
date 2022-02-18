![Logo Banner Light](./Images/logo_banner.svg#gh-light-mode-only)
![Logo Banner Dark](./Images/logo_banner~dark.svg#gh-dark-mode-only)

![Github Workflow](https://img.shields.io/github/workflow/status/baidu/CarbonGraph/build/main?style=flat-square)&nbsp;
![Swift Version](https://img.shields.io/badge/Swift-5.2--5.5-orange?style=flat-square)&nbsp;
![CocoaPods Version](https://img.shields.io/cocoapods/v/CarbonCore?style=flat-square)&nbsp;
![Platforms](https://img.shields.io/cocoapods/p/CarbonCore?style=flat-square)&nbsp;
![License](https://img.shields.io/cocoapods/l/CarbonCore?style=flat-square)

CarbonGraph is a Swift dependency injection / lookup framework for iOS. You can use it to build loose coupling between modules.

The CarbonGraph project contains 2 frameworks:

| Framework | Description |
| --- | --- |
| CarbonCore | Focused specifically on core DI implementations |
| CarbonObjC | CarbonCore's ObjC adaptation framework |

## Features

- [x] Complete dependency injection capabilities
- [x] Complete Objective-C support
- [x] Convenient object definition DSL
- [x] High-performance thread-safe solution
- [x] Support resolving native Swift types
- [x] Support resolving with external parameters
- [x] Support resolving with circular dependencies
- [x] Automatic scanning of configuration
- [x] Additional module life cycle management capabilities

## Requirements

* CarbonCore Requirements

| CarbonCore Stable Version | Required iOS Version | Required Swift Version |
| --- | --- | --- |
| 1.2.2, 1.3.1 | 9.0 | 5.2 |

* CarbonObjC Version Compatibility

| CarbonObjC Version | CarbonCore Compatible Version |
| --- | --- |
| 1.2.2 | 1.2.2 |
| 1.3.1 | 1.3.1 |

For more information see [Compatibility](./CarbonCore/CarbonCore/CarbonCore.docc/Compatibility.md)

## Installation

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CarbonGraph into your Xcode project using CocoaPods, specify it in your Podfile:

> pod 'CarbonCore', '~> 1.3.1'

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

## Basic usage

> Note: For convenience, the registration of object definitions and the creation of context that appear in the following will be omitted. All definitions in your project must be registered before they can be resolved.

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
    .setter(FileViewController.setFileManager(fileManager:))
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

For more information see [Basic usage](./CarbonCore/CarbonCore/CarbonCore.docc/BasicUsage.md)

## Documentation

The documentation of this project is written in [DocC](https://developer.apple.com/documentation/docc), please clone the repo and build the documentation yourself.

1. Clone this repo 
2. Open Carbon.xcworkspace with Xcode
3. Product > Build Documentation

For more information see Unit Test and Example

## Contribution

You are more than welcome to contribute code to the project，for more information see [Contribution](./CarbonCore/CarbonCore/CarbonCore.docc/Contribution.md)

## Credits

The idea of using dependency injection to build loosely coupled project comes from [Spring](https://spring.io). The ideas of using generics to implement factory injection comes from [Swinject](https://github.com/Swinject/Swinject). Thanks to these frameworks for providing these excellent ideas.

## License

CarbonGraph is released under the MIT license. See [LICENSE](https://console.cloud.baidu-int.com/devops/icode/repos/baidu/netdisk/ios-carbon-lib/blob/master:LICENSE) for details.
