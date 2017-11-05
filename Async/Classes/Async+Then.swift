import then

extension Async {
    func then() -> Promise<T> {
        return Promise { resolve, reject in
            self.future.onSuccess { value in
                resolve(value)
            }.onFailure { error in
                    reject(error)
            }
        }
    }
}
