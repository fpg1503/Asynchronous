import Hydra
import Result

/// Add suport to *Hydra*'s `Promise`s
/// `Hydra.Promise` <--> `Async`
extension Async {
    /// Returns a *Hydra* `Promise` in a given context that can be
    /// invalidated
    ///
    /// - Parameters:
    ///     - context: Context (GCD queue) in which the body of
    /// the promise is executed
    /// By default background queue is used.
    ///     - token: optional invalidation token
    /// - Returns: A *Hydra* `Promise` in a given context that
    /// can be invalidated
    public func promise(in context: Context? = nil, token: InvalidationToken? = nil) -> Promise<T> {
        return hydra(in: context, token: token)
    }

    /// Returns a *Hydra* `Promise` in a given context that can be
    /// invalidated
    ///
    /// - Parameters:
    ///     - context: Context (GCD queue) in which the body of
    /// the promise is executed
    /// By default background queue is used.
    ///     - token: optional invalidation token
    /// - Returns: A *Hydra* `Promise` in a given context that
    /// can be invalidated
    public func hydra(in context: Context? = nil, token: InvalidationToken? = nil) -> Promise<T> {
        //TODO: Figure out if we have to do something to support invalidation
        return Promise(in: context, token: token) { resolve, reject, _ in
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

    /// Creates a new `Async` from a *Hydra* `Promise`
    /// that can be fulfilled or rejected
    ///
    /// - Parameters:
    ///     - promise: a *Hydra* `Promise`
    /// - Returns: A new `Async` from a given *Hydra*
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

