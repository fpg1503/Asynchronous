import Foundation
import BrightFutures
import Result

public enum AsyncError<T: Error>: Error {
    case valueAndErrorNil
    case some(T)
}

public typealias Async<T> = AsyncWithError<T, AnyError>

public struct AsyncWithError<T, Error: Swift.Error> {
    
    public let future: Future<T, Error>
    
    public init(future: Future<T, Error>) {
        self.future = future
    }
    
    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        self.future = Future { resolve in
            resolver({ value in
                resolve(.success(value))
            }, { error in
                resolve(.failure(error))
            })
        }
    }
    
    public static func from<SomeError: Swift.Error>(_ resolver: @escaping (_ completion: (T?, SomeError?) -> Void) -> Void) -> AsyncWithError<T, AsyncError<SomeError>> {
        return AsyncWithError<T, AsyncError<SomeError>> { resolve, reject in
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
        future.onComplete { (result) in
            completion(result.value, result.error)
        }
    }
    
    public func async(_ completion: @escaping (Result<T, Error>) -> Void) {
        future.onComplete { (result) in
            completion(result)
        }
    }
}
