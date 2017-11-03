import BrightFutures
import Result

extension Async {
    func future() -> Future<T, AnyError> {
        return Future { resolver in
            promise.then { value in
                resolver(.success(value))
            }.catch { error in
                resolver(.failure(AnyError(error)))
            }
        }
    }
}
