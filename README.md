# Asynchronous

[![CI Status](http://img.shields.io/travis/fpg1503/Asynchronous.svg?style=flat)](https://travis-ci.org/fpg1503/Asynchronous)
[![Version](https://img.shields.io/cocoapods/v/Asynchronous.svg?style=flat)](http://cocoapods.org/pods/Asynchronous)
[![License](https://img.shields.io/cocoapods/l/Asynchronous.svg?style=flat)](http://cocoapods.org/pods/Asynchronous)
[![Platform](https://img.shields.io/cocoapods/p/Asynchronous.svg?style=flat)](http://cocoapods.org/pods/Asynchronous)
[![codecov](https://codecov.io/gh/fpg1503/Asynchronous/branch/master/graph/badge.svg?token=tYItlSv7iF)](https://codecov.io/gh/fpg1503/Asynchronous)


Asynchronous is a one-stop shop for your async needs, the user can use the subspecs to automatically run the Async code using completion handlers, [BrightFutures](https://github.com/Thomvis/BrightFutures), [HydraAsync](https://github.com/malcommac/Hydra), [PromiseKit](https://github.com/mxcl/PromiseKit), [Promises](https://github.com/khanlou/Promise), [then](https://github.com/freshOS/then) and much more!

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Async is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Asynchronous'
```

## Available Subspecs
| Name | Description |
|-------|------------|
| `Asynchronous/Alamofire` | [Alamofire](https://github.com/Alamofire/Alamofire) support |
| `Asynchronous/BrightFutures` |  [BrightFutures](https://github.com/Thomvis/BrightFutures) support |
| `Asynchronous/HydraAsync` |  [HydraAsync](https://github.com/malcommac/Hydra) support |
| `Asynchronous/PromiseKit` | [PromiseKit](https://github.com/mxcl/PromiseKit) support |
| `Asynchronous/Promises` |  [Promises](https://github.com/khanlou/Promise) support |
| `Asynchronous/Then` |  [then](https://github.com/freshOS/then) support |

## Contributing
Feel free to create a PR/Issue.

### Roadmap
- [ ] ReactiveSwift support
- [ ] RxSwift support
- [x] Tests
- [ ] Better documentation
- [ ] Improved README
- [x] Remove BrightFutures dependency
- [ ] Carthage support
- [ ] SwiftPM support

## Author

Francesco Perrotti-Garcia, fpg1503@gmail.com

## License

Asynchronous is available under the MIT license. See the LICENSE file for more info.
