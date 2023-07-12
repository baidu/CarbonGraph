# Contribution

Contribute code to the project.

## Overview

If you find an issue with the project, or have a feature suggestion, you can open an issue on Github.

You are more than welcome to contribute code to the project. You can contribute by fixing bugs or adding new features. For larger code changes, we first recommend discussing them in our Github issues. When submitting a pull request, please ensure 100% unit test coverage of new code and try to adapt to ObjC as much as possible.

> Unit Tests
> 1. Open Carbon.xcworkspace with Xcode
> 2. Execute Command + U under CarbonCore and CarbonObjC Scheme respectively

The project administrator will merge the stable-state feature branch into the develop branch at the appropriate time, delete the feature branch, and create a new release branch based on develop. Projects that require early access to new features can always utilize the code from the release branch. Once a release is completed for at least one project, the release branch will be merged back into the develop and main branches, and the new version will be released on the main branch.

Release commands reference:
```
pod lib lint CarbonCore.podspec
git tag x.x.x
git push origin x.x.x
pod spec lint CarbonCore.podspec
pod trunk push CarbonCore.podspec
```

## Join us

The project is still in the early stage, and will build more dependency injection capabilities such as files and databases in the future, continue to expand the DSL syntax, and develop extensions for the system framework to simplify iOS. etc. If you want to deeply participate in the development of the project, you can contact us to join the core contribution team and explore the future together.

| Tool | Address | Description |
| --- | --- | --- |
| WeChat | Check the QR code below | CarbonGraph discussion group |
| Email | carbon-core@baidu.com | CarbonGraph core contributors email group |

<a href="https://weixin.qq.com/g/AQYAAMrdukzdvyo_JJrKIVjcJXhKFS2Of8v1P6K3bQIIwZ28E1BWAcsfbGWFKEHs"><img width="360" src="Resources/wechat_qr_code.jpg"></a>&nbsp;

## Credits

The idea of using dependency injection to build loosely coupled project comes from [Spring](https://spring.io). The ideas of using generics to implement factory injection comes from [Swinject](https://github.com/Swinject/Swinject). Thanks to these frameworks for providing these excellent ideas.

### Contributors

Thanks to everyone who have already contributed to CarbonGraph!

<a href="https://github.com/xiaofei86"><img width="40" height="40" src="https://avatars.githubusercontent.com/u/8192632"></a>&nbsp;
<a href="https://github.com/lqwang521"><img width="40" height="40" src="https://avatars.githubusercontent.com/u/12582303"></a>&nbsp;
<a href="https://github.com/aipinn"><img width="40" height="40" src="https://avatars.githubusercontent.com/u/16027318"></a>&nbsp;
<a href="https://github.com/stronggbbz"><img width="40" height="40" src="https://avatars.githubusercontent.com/u/4352237"></a>&nbsp;

