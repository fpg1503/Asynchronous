# Asynchronous

[![CI Status](http://img.shields.io/travis/fpg1503/Asynchronous.svg?style=flat)](https://travis-ci.org/fpg1503/Asynchronous)
[![Version](https://img.shields.io/cocoapods/v/Asynchronous.svg?style=flat)](http://cocoapods.org/pods/Asynchronous)
[![License](https://img.shields.io/cocoapods/l/Asynchronous.svg?style=flat)](http://cocoapods.org/pods/Asynchronous)
[![Platform](https://img.shields.io/cocoapods/p/Asynchronous.svg?style=flat)](http://cocoapods.org/pods/Asynchronous)
[![Documentation](https://img.shields.io/cocoapods/metrics/doc-percent/Asynchronous.svg)](http://cocoadocs.org/docsets/Asynchronous/)
[![codecov](https://codecov.io/gh/fpg1503/Asynchronous/branch/master/graph/badge.svg?token=tYItlSv7iF)](https://codecov.io/gh/fpg1503/Asynchronous)


Asynchronous is a one-stop shop for your async needs, the user can use the subspecs to automatically run the Async code using completion handlers, [BrightFutures](https://github.com/Thomvis/BrightFutures), [HydraAsync](https://github.com/malcommac/Hydra), [PromiseKit](https://github.com/mxcl/PromiseKit), [Promises](https://github.com/khanlou/Promise), [then](https://github.com/freshOS/then) and much more!

The ultimate answer to **which asynchronous abstraction should I use in my API?**, just use `Asynchronous` and give your users freedom without the headache of adding several dependencies and different abstractions to your code!

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Sample use case

Let's say you're writing a mobile SDK that does asynchronous tasks (such as HTTP requests), just like the following:
```swift
func getUser(by id: String) -> Async<User> {
    return Async { resolve, reject in
        let url = APIRouter.route(for: .users, id: id)
        let request = URLRequest(url: url)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                reject(error) // You can also `throw error`!
            } else if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    resolve(user)
                } catch (let error) {
                    reject(error)
                }
            } else {
                reject(NSError(domain: "my.domain", code: 123))
            }
        }
        task.resume()
    }
}
```

That's it! You simply create an `Async` and call `resolve` or `reject` once your task is finished.

The user can either add a completion block or use their favorite asynchronous abstraction:

### Completion
```swift
apiClient.getUser(by: id).async { user, error in
    if let user = value {
        userName.text = user.name
    } else {
        display(error: error)
    }
}
```

### Promise
```swift
apiClient.getUser(by: id).promise()
.then { user in
    userName.text = user.name
}.catch { error in
    display(error: error)
}
``` 

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
Contributions are encourajed and appreciated!
For more information take a look at [CONTRIBUTING.md](CONTRIBUTING.md).

### Roadmap
- [ ] ReactiveSwift support
- [x] RxSwift support
- [x] Tests
- [x] Better documentation
- [ ] Improved README
- [x] Remove BrightFutures dependency
- [ ] Carthage support
- [ ] SwiftPM support
- [x] Fix unnecessary error type erasures
- [ ] Fix tuple gate in Asyncify
- [ ] Improve Example project

## Author

Francesco Perrotti-Garcia, fpg1503@gmail.com

## License

Asynchronous is available under the MIT license. See the LICENSE file for more info.
