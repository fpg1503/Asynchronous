import Foundation
import Result

public enum AsyncError<T: Error>: Error {
    case valueAndErrorNil
    case some(T)
}

public typealias Async<T> = FailableAsync<T, AnyError>
public typealias InfailableAsync<T> = FailableAsync<T, NoError>

public struct FailableAsync<T, Error: Swift.Error> {

    public let backingFuture: LightweightFuture<T, Error>

    public init(future: LightweightFuture<T, Error>) {
        self.backingFuture = future
    }

    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        
        self.backingFuture = LightweightFuture { (resolve, reject) in
            resolver(resolve, reject)
        }
    }

    public static func from(future: LightweightFuture<T, Error>) -> FailableAsync<T, Error> {
        return FailableAsync(future: future)
    }

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

    public func async(_ completion: @escaping (T?, Error?) -> Void) {
        backingFuture.onComplete { (result) in
            completion(result.value, result.error)
        }
    }

    public func async(_ completion: @escaping (Result<T, Error>) -> Void) {
        backingFuture.onComplete { (result) in
            completion(result)
        }
    }
}
