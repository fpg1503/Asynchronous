import Promise
import Result

/// Add suport to *Promises*' `Promise`s.
///
/// `Promise.Promise` <--> `Async`
extension Async {
    /// Returns a *Promises* `Promise`.
    /// - Returns: A *Promises* `Promise`.
    public func promise() -> Promise<T> {
        return promises()
    }

    /// Returns a *Promises* `Promise`.
    /// - Returns: A *Promises* `Promise`.
    public func promises() -> Promise<T> {
        return Promise { (resolve, reject) in
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

    /// Creates a new `Async` from a *Promises* `Promise`
    /// that can be fulfilled or rejected.
    ///
    /// - Parameters:
    ///     - promise: A *Promises* `Promise`.
    /// - Returns: A new `Async` from a given *Promises*
    /// `Promise` that can be fulfilled or rejected.
    public static func from(promise: Promise<T>) -> Async<T> {
        return Async { resolve, reject in
            promise.then { value in
                resolve(value)
            }.catch { error in
                reject(error)
            }
        }
    }
}

