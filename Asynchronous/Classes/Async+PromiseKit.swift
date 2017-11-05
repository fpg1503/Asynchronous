import PromiseKit
import Result

extension Async {
    public func promise() -> Promise<T> {
        return Promise { (resolve, reject) in
            future.onSuccess { value in
                resolve(value)
            }.onFailure { error in
                reject(error)
            }
        }
    }
    
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
