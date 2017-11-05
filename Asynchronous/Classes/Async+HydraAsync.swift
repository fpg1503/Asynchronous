import Hydra
import Result

extension Async {
    func hydra(in context: Context? = nil, token: InvalidationToken? = nil) -> Promise<T> {
        return Promise(in: context, token: token) { resolve, reject, _ in
            self.future.onSuccess { value in
                resolve(value)
            }.onFailure { error in
                reject(error)
            }
        }
    }
    
    static func from(promise: Promise<T>) -> Async<T> {
        return Async { resolve, reject in
            promise.then { value in
                resolve(value)
            }.catch { error in
                reject(AnyError(error))
            }
        }
    }
}

