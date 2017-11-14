import Result

/// Describes an asynchronous operation that may fail
/// with a type erased error (`Result.AnyError`).
public typealias Async<T> = FailableAsync<T, AnyError>

/// Automatic error type erasure and throw support
extension Async where Error == AnyError {
    // The `where` clause is redundant but the compiler has serious troubles
    // if we remove it :/

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
    /// occurred. You can also `throw` your errors!
    ///     - fulfill: Completion to be called if the async
    /// is fulfilled.
    ///     - reject: Completion to be called if the async
    /// is rejected. You can also `throw` your errors!
    public init(resolver: @escaping (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Swift.Error) -> Void) throws -> Void) {

        func typeErase(reject: @escaping (AnyError) -> Void) -> (Swift.Error) -> Void {
            return { error in
                // AnyError automatically avoids recursive AnyErrors
                reject(AnyError(error))
            }
        }

        self.backingFuture = LightweightFuture { (resolve, reject) in
            let typeErasingReject = typeErase(reject: reject)
            do {
                try resolver(resolve, typeErasingReject)
            } catch let error {
                typeErasingReject(error)
            }
        }
    }
}
