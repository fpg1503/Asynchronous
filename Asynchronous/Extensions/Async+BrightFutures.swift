import BrightFutures
import Result

/// Add suport to *BrightFutures*' `Future`s.
///
/// `BrightFutures.Future` <--> `FailableAsync`
extension FailableAsync {
    /// Returns a *BrightFutures* `Future`.
    /// - Returns: A *BrightFutures* `Future`.
    public func future() -> Future<T, Error> {
        return brightFutures()
    }

    /// Returns a *BrightFutures* `Future`.
    /// - Returns: A *BrightFutures* `Future`.
    public func brightFutures() -> Future<T, Error> {
        return Future { resolver in
            self.backingFuture.onComplete(resolver: resolver)
        }
    }

    /// Creates a new `FailableAsync` from a *BrightFutures* `Future`
    /// that can be fulfilled or rejected.
    ///
    /// - Parameters:
    ///     - promise: A *BrightFutures* `Future`.
    /// - Returns: A new `FailableAsync` from a given *BrightFutures*
    /// `Future` that can be fulfilled or rejected.
    public static func from(future: Future<T, Error>) -> FailableAsync<T, Error> {
        return FailableAsync { resolve, reject in
            future.onSuccess { value in
                resolve(value)
            }.onFailure { error in
                reject(error)
            }
        }
    }
}
