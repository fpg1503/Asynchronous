import PromiseKit

extension Async {
    func promise() -> Promise<T> {
        return Promise { (resolve, reject) in
            future.onSuccess { value in
                resolve(value)
            }.onFailure { error in
                reject(error)
            }
        }
    }
}
