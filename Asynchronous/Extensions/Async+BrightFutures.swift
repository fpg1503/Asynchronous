import BrightFutures
import Result

extension FailableAsync {
    public func future() -> Future<T, Error> {
        return Future { resolver in
            self.backingFuture.onComplete(resolver: resolver)
        }
    }
    
    public static func from(future: Future<T, Error>) -> FailableAsync<T, Error> {
        return FailableAsync { resolve, reject in
            future.onSuccess { value in
                resolve(value)
            }.onFailure { error in
                reject(error)
            }
        }
    }
}
