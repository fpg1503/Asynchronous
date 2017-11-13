import PromiseKit
import Result

/// Add suport to *PromiseKit*'s `Promise`s
/// `PromiseKit.Promise` <--> `Async`
extension Async {
    /// Returns a *PromiseKit* `Promise`
    /// - Returns: A *PromiseKit* `Promise`
    public func promise() -> Promise<T> {
        return promiseKit()
    }

    /// Returns a *PromiseKit* `Promise`
    /// - Returns: A *PromiseKit* `Promise`
    public func promiseKit() -> Promise<T> {
        return Promise { (resolve, reject) in
            backingFuture.onComplete { result in
                switch result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }

    /// Creates a new `Async` from a *PromiseKit* `Promise`
    /// that can be fulfilled or rejected
    ///
    /// - Parameters:
    ///     - promise: a *PromiseKit* `Promise`
    /// - Returns: A new `Async` from a given *PromiseKit*
    /// `Promise` that can be fulfilled or rejected
    public static func from(promise: Promise<T>) -> Async<T> {
        return Async { resolve, reject in
            promise.then { value in
                resolve(value)
            }.catch { error in
                reject(AnyError(error))
            }
        }
    }
}
