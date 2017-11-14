import Result

/// Describes an asynchronous operation that may fail
/// with a type erased error (`Result.AnyError`).
public typealias Async<T> = FailableAsync<T, AnyError>

extension Async where Error == AnyError {
    /// Creates an `Async` that can be fulfilled
    /// or rejected.
    ///
    /// - Parameters:
    ///     - resolver: A closure that is passed two arguments:
    /// `fulfill` and `reject`. The `resolver` closure is executed
    /// immediately by the `Async` implementation, passing
    /// `fulfill` and `reject` closures (the `resolver` is called before
    /// the `Async` constructor even returns the created
    /// Async). The `resolver` normally initiates some asynchronous
    /// work, and then, once that completes, either calls the `fulfill`
    /// function to resolve the future or else `reject`s it if an error
    /// occurred.
    ///     - fulfill: Completion to be called if the async
    /// is fulfilled.
    ///     - reject: Completion to be called if the async
    /// is rejected.
    public init(resolver: @escaping (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Swift.Error) -> Void) -> Void) {

        func typeErasingReject(reject: @escaping (AnyError) -> Void) -> (Swift.Error) -> Void {
            return { error in
                let anyError = { error -> AnyError in
                    if let anyError = error as? AnyError {
                        return anyError
                    } else {
                        return AnyError(error)
                    }
                }(error)
                reject(anyError)
            }
        }

        self.backingFuture = LightweightFuture { resolve, reject in
            resolver(resolve, typeErasingReject(reject: reject))
        }
    }
}
