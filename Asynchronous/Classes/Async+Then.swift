import then
import Result

extension Async {
    public func then() -> Promise<T> {
        return Promise { resolve, reject in
            self.future.onSuccess { value in
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
            }.onError { error in
                reject(AnyError(error))
            }
        }
    }
}
