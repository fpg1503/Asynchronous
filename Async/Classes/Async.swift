import Foundation
import PromiseKit

enum AsyncError: Error {
    case valueAndErrorNil
}

public struct Async<T> {
    
    public let promise: Promise<T>
    
    public init(promise: Promise<T>) {
        self.promise = promise
    }
    
    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        self.promise = Promise(resolvers: resolver)
    }
    
    public init(resolver: @escaping (_ completion: (T?, Error?) -> Void) -> Void) {
        self.promise = Promise<T> { (resolve, reject) in
            resolver { (value, error) in
                if let value = value {
                    resolve(value)
                } else if let error = error {
                    reject(error)
                } else {
                    reject(AsyncError.valueAndErrorNil)
                }
            }
        }
    }
    
    public func async(_ completion: @escaping (T?, Error?) -> Void) {
        promise.then { value in
            completion(value, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
}
