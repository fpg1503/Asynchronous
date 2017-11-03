import Result

extension Async {
    func async(_ completion: @escaping (Result<T, AnyError>) -> Void) {
        promise.then { value in
            completion(.success(value))
        }.catch { error in
            completion(.failure(AnyError(error)))
        }
    }
}
