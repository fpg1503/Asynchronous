import Foundation
import Result

/// An enum representing every possible error for errors returned by Async
/// An `AsyncError` can also wrap an external error (e.g. coming from a user defined future)
/// in its `some` case. `AsyncError` has the type of the external error as its generic parameter.
public enum AsyncError<T: Error>: Error {
    /// Describes a illegal state when a user provides both value
    /// and error `nil`
    case valueAndErrorNil

    /// Wraps a generic Swift.Error instance
    case some(T)
}

/// Describes an asynchronous operation that may fail
/// with a type erased error (`Result.AnyError`)
public typealias Async<T> = FailableAsync<T, AnyError>

/// Describes an asynchronous operation that will always succeed
/// with an error that can never be instantiated (`Result.NoError`)
public typealias InfailableAsync<T> = FailableAsync<T, NoError>

/// Describes an asynchronous operation that may fail
/// with a generic error
public struct FailableAsync<T, Error: Swift.Error> {

    /// The future used to back the async. Use it if you are
    /// extending `Asynchronous` to add your own abstraction
    public let backingFuture: LightweightFuture<T, Error>

    /// Creates a new `FailableAsync` with a given backing
    /// `LightweightFuture` that can be fulfilled
    /// or rejected
    ///
    /// - Parameters:
    ///     - future: the backing future
    public init(future: LightweightFuture<T, Error>) {
        self.backingFuture = future
    }

    /// Creates a `FailableAsync` that can be fulfilled
    /// or rejected
    ///
    /// - Parameters:
    ///     - resolver: a closure that is passed two arguments:
    /// `fulfill` and `reject`. The `resolver` closure is executed
    /// immediately by the `FailableAsync` implementation, passing
    /// `fulfill` and `reject` closures (the `resolver` is called before
    /// the `FailableAsync` constructor even returns the created
    /// Async). The `resolver` normally initiates some asynchronous
    /// work, and then, once that completes, either calls the `fulfill`
    /// function to resolve the future or else `reject`s it if an error
    /// occurred.
    ///     - fulfill: completion to be called if the async
    /// is fulfilled
    ///     - reject: completion to be called if the async
    /// is rejected
    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        
        self.backingFuture = LightweightFuture { (resolve, reject) in
            resolver(resolve, reject)
        }
    }

    /// Creates a new `FailableAsync` from a given backing
    /// `LightweightFuture` that can be fulfilled
    /// or rejected
    ///
    /// - Parameters:
    ///     - future: the backing future
    /// - Returns: A new `FailableAsync` from a given backing
    /// `LightweightFuture` that can be fulfilled
    /// or rejected
    public static func from(future: LightweightFuture<T, Error>) -> FailableAsync<T, Error> {
        return FailableAsync(future: future)
    }

    /// Creates a `FailableAsync` that can be fulfilled
    /// or rejected
    ///
    /// - Parameters:
    ///     - resolver: a closure that is passed one argument:
    /// `completion`. The `resolver` closure is executed
    /// immediately by the `FailableAsync` implementation, passing
    ///  the `completion` closure (the `resolver` is called before
    /// the `FailableAsync` constructor even returns the created
    /// Async). The `resolver` normally initiates some asynchronous
    /// work, and then, once that completes, calls the `completion`
    /// function giving either a *non-nil value and a nil error*
    /// or a *nil value and a non-nil error*.
    ///     - completion: completion to be when the async
    /// computation has finished
    /// - Returns: A new `FailableAsync` from a given backing
    /// `LightweightFuture` that can be fulfilled
    /// or rejected
    public static func from<SomeError: Swift.Error>(_ resolver: @escaping (_ completion: (T?, SomeError?) -> Void) -> Void) -> FailableAsync<T, AsyncError<SomeError>> {
        return FailableAsync<T, AsyncError<SomeError>> { resolve, reject in
            resolver { (value, error) in
                if let value = value {
                    resolve(value)
                } else if let error = error {
                    reject(.some(error))
                } else {
                    reject(.valueAndErrorNil)
                }
            }
        }
    }

    /// Attaches a completion handler to she finish of the asynchronous
    /// computation. Your completion closure will receive a tuple
    /// containing an optional value and an optional error.
    ///
    /// - Parameters:
    ///     - completion: completion closure to be invoked when
    /// the asynchronous task is finished
    public func async(_ completion: @escaping (T?, Error?) -> Void) {
        backingFuture.onComplete { (result) in
            completion(result.value, result.error)
        }
    }

    /// Attaches a completion handler to she finish of the asynchronous
    /// computation. Your completion closure will receive a `Result`
    /// tha contains either a value or an error.
    ///
    /// - Parameters:
    ///     - completion: completion closure to be invoked when
    /// the asynchronous task is finished
    public func async(_ completion: @escaping (Result<T, Error>) -> Void) {
        backingFuture.onComplete { (result) in
            completion(result)
        }
    }
}
