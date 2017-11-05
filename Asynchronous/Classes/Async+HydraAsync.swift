import Hydra

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
}

