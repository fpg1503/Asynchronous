import RxSwift
import Result

/// Add suport to *RxSwift*'s `Single`s.
///
/// `RxSwift.Single` <--> `Async`
extension Async {
    /// Returns a *RxSwift* `Observable`.
    /// - Returns: A *RxSwift* `Observable`.
    public func asObservable() -> Observable<T> {
        return asSingle().primitiveSequence.asObservable()
    }

    /// Returns a *RxSwift* `Single`.
    /// - Returns: A *RxSwift* `Single`.
    public func asSingle() -> Single<T> {
        return Single<T>.create { single in
            self.backingFuture.onComplete { result in
                switch result {
                case .success(let value):
                    single(.success(value))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    //TODO: Think if this is the best way to represent other Observables
    /// Creates a new `Async` from a *RxSwift* `Observable`
    /// that can be fulfilled or rejected.
    ///
    /// - Parameters:
    ///     - promise: A *RxSwift* `Observable`.
    /// - Returns: A new `Async` from a given *RxSwift*
    /// `RxSwift` that can be fulfilled or rejected.
    public static func from(observable: Observable<T>) -> Async<T> {
        return Async.from(single: observable.asSingle())
    }

    /// Creates a new `Async` from a *RxSwift* `Single`
    /// that can be fulfilled or rejected.
    ///
    /// - Parameters:
    ///     - promise: A *RxSwift* `Single`.
    /// - Returns: A new `Async` from a given *RxSwift*
    /// `RxSwift` that can be fulfilled or rejected.
    public static func from(single: Single<T>) -> Async<T> {
        return Async { resolve, reject in
            single
                .subscribe(onSuccess: { value in
                    resolve(value)
                }, onError: { error in
                    reject(error)
                })

            //TODO: dispose!
        }
    }
}
