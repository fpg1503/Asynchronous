import Promise
import Result

extension Async {
    public func promise() -> Promise<T> {
        return promises()
    }

    public func promises() -> Promise<T> {
        return Promise { (resolve, reject) in
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

