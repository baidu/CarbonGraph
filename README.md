![Logo Banner Light](./Images/logo_banner-light.svg#gh-light-mode-only)
![Logo Banner Dark](./Images/logo_banner-dark.svg#gh-dark-mode-only)

![Swift Version](https://img.shields.io/badge/Swift-5.2--5.5-orange?style=flat-square)&nbsp;
![Platforms](https://img.shields.io/badge/platform-ios-lightgray?style=flat-square)&nbsp;
![License](https://img.shields.io/badge/license-MIT-black.svg?style=flat-square)&nbsp;

CarbonGraph is a Swift dependency injection / lookup framework for iOS. You can use it to build loose coupling between modules.

| Framework | Description |
| --- | --- |
| CarbonCore | The main implementation of CarbonGraph |
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

| CarbonGraph Stable Version | Required iOS Version | Required Swift Version |
| --- | --- | --- |
| 1.2.2 | 9.0 | 5.2 |

### Compatibility

| Xcode Version | Swift Version | MacOS Version | Build for distribution |
| --- | --- | --- | --- |
| 11.4 | 5.2 | Catalina 10.15.7 | passing |
| 12.1 | 5.3 | Catalina 10.15.7 | passing |
| 12.4 | 5.3.2 | Catalina 10.15.7 | passing |
| ~~12.5~~ | ~~5.4~~ | ~~Big Sur 11.6~~ | ~~error~~ |
| ~~12.5.1~~ | ~~5.4.2~~ | ~~Big Sur 11.6~~ | ~~error~~ |
| 13.0 | 5.5 | Big Sur 11.6 | passing |

## Installation

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CarbonGraph into your Xcode project using CocoaPods, specify it in your Podfile:

> pod 'CarbonCore', '~> 1.2.2'

## Basic Usage

* Basic object registration and resolving
```swift
let context = ApplicationContext()
context.register(builder: Definition().object(FilePath()))
appContext[FilePath.self]
```

* Use configuration batch registration
```swift
class MyConfiguration: ScannableObject, Configuration {
    static func definitions() -> Definitions {
        Definition()
            .object(FilePath())
        Definition()
            .constructor(FileModel.init(filePath:))
        Definition()
          .factory { _ in FileModel(path: “/“) }
    }
}

let context = ApplicationContext()
context.register(configuration: MyConfiguration.self)
```

* Multiple object definition methods
```swift
Definition().object(FilePath())
Definition().constructor(FilePath.init)
Definition().factory { _ in FilePath() }
Definition().factory(createFilePath())

static func createFilePath(context: ObjectContext) -> FilePath { FilePath() }
```

* Define protocol alias for object
```swift
Definition()
    .object(FileModel(path: "/") as FileModelProtocol)
```

* Define multiple protocol aliases for the object
```swift
Definition()
    .protocol(FileManagerProtocol.self)
    .alias(ImageManagerProtocol.self)
    .alias(DirectoryManagerProtocol.self)
    .object(FileManager())
```

* Use constructor for dependency injection
```swift
Definition()
    .constructor(FileModel.init(filePath:))
```

* Use property for dependency injection
```swift
Definition()
    .protocol(FileViewControllerProtocol.self)
    .object(FileViewController())
    .property(\.avatarFactory)
```

* Use setter for dependency injection
```swift
Definition()
    .protocol(FileViewControllerProtocol.self)
    .object(FileViewController())
    .setter(FileViewController.setAvatarFactory)
```

* Use static factory for dependency injection
```swift
Definition()
    .factory(fileModel(context:filePath:))
appContext[FileModelProtocol.self]

static func fileModel2(context: ObjectContext, filePath: FilePath) -> FileModelProtocol {
    FileModel(path: filePath.path, name: filePath.name)
}
```

* Use a static factory for manual dependency injection
```swift
Definition()
    .factory { ctx in FileModel(filePath: ctx[FilePath.self]) as FileModelProtocol }
appContext[FileModelProtocol.self]
```

* Create objects with external parameters
```swift
Definition()
    .factory(fileModel(context:arg1:arg2:))
appContext[FileModelProtocol.self, "/china/beijing", "family.png"]

static func fileModel(context: ObjectContext, arg1: String, arg2: String) -> FileModelProtocol {
    FileModel(path: arg1, name: arg2)
}
```

For more usage scenarios, please refer to Netdisk Demo or related unit test cases, or contact us for help.

## Unit Tests

1. Open Carbon.xcworkspace with Xcode
2. Execute Command + U in Xcode

## Discussion

| Tool | Address | Description |
| --- | --- | --- |
| Infoflow | 5346856 | CarbonGraph users discussion group |
| Email | carbon-core@baidu.com | CarbonGraph core contributors email group |

## Credits

The idea of using dependency injection to build loosely coupled projects is from [Spring](https://spring.io). The implementation of using generics to obtain method parameter types is from [Swinject](https://github.com/Swinject/Swinject).

Thanks for the excellent ideas and implementation provided by the above framework.

## License

CarbonGraph is released under the MIT license. See [LICENSE](https://console.cloud.baidu-int.com/devops/icode/repos/baidu/netdisk/ios-carbon-lib/blob/master:LICENSE) for details.
