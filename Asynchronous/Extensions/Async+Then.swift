import then
import Result

/// Add suport to *then*'s `Promise`s.
///
/// `then.Promise` <--> `Async`
extension Async {
    /// Returns a *then* `Promise`.
    /// - Returns: A *then* `Promise`.
    public func promise() -> Promise<T> {
        return then()
    }

    /// Returns a *then* `Promise`.
    /// - Returns: A *then* `Promise`.
    public func then() -> Promise<T> {
        return Promise { resolve, reject in
            self.backingFuture.onComplete { result in
                switch result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }

    /// Creates a new `Async` from a *then* `Promise`
    /// that can be fulfilled or rejected.
    ///
    /// - Parameters:
    ///     - promise: A *then* `Promise`.
    /// - Returns: A new `Async` from a given *then*
    /// `Promise` that can be fulfilled or rejected.
    public static func from(promise: Promise<T>) -> Async<T> {
        return Async { resolve, reject in
            promise.then { value in
                resolve(value)
            }.onError { error in
                reject(error)
            }
        }
    }
}
