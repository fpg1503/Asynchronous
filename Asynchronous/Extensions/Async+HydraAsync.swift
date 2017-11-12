import Hydra
import Result

extension Async {
    public func promise(in context: Context? = nil, token: InvalidationToken? = nil) -> Promise<T> {
        return hydra(in: context, token: token)
    }

    public func hydra(in context: Context? = nil, token: InvalidationToken? = nil) -> Promise<T> {
        return Promise(in: context, token: token) { resolve, reject, _ in
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

