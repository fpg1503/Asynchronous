import Foundation
import Result

/// A lightweight future used to abstract asynchronous actions
/// that may fail
public final class LightweightFuture<T, Error: Swift.Error> {
    indirect enum State<T, Error: Swift.Error> {
        case pending
        case fulfilled(T)
        case rejected(Error)

        var isPending: Bool {
            switch self {
            case .pending:
                return true
            default:
                return false
            }
        }
    }

    /// The result type of this future
    public typealias FutureResult = Result<T, Error>

    /// A closure that consumes a `FutureResult`
    public typealias Consumer = (FutureResult) -> Void
    private var pendencies: [Consumer] = []
    private func process(consumer: @escaping Consumer) {
        switch state {
        case .pending:
            pendencies.append(consumer)
        case .fulfilled(let value):
            consumer(.success(value))
        case .rejected(let error):
            consumer(.failure(error))
        }
    }

    var state: State<T, Error> = .pending {
        didSet {
            guard oldValue.isPending,
                !state.isPending else {
                    print("Invalid transition from \(oldValue) to \(state), reverting")
                    state = oldValue
                    return
            }

            for pendency in pendencies {
                process(consumer: pendency)
            }
            pendencies = []
        }
    }

    /// Creates a Lightweight Future that can be fulfilled
    /// or rejected
    ///
    /// - Parameters:
    ///     - resolver: a closure that is passed two arguments:
    /// `fulfill` and `reject`. The `resolver` closure is executed
    /// immediately by the `LightweightFuture` implementation, passing
    /// `fulfill` and `reject` closures (the `resolver` is called before
    /// the `LightweightFuture` constructor even returns the created
    /// object). The `resolver` normally initiates some asynchronous
    /// work, and then, once that completes, either calls the `fulfill`
    /// function to resolve the future or else `reject`s it if an error
    /// occurred.
    ///     - fulfill: completion to be called if the future
    /// is fulfilled
    ///     - reject: completion to be called if the future
    /// is rejected
    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        resolver(fulfill, reject)
    }

    private func fulfill(value: T) {
        self.state = .fulfilled(value)
    }

    private func reject(error: Error) {
        self.state = .rejected(error)
    }

    /// Adds the given closure as a callback for when the
    /// Future completes.
    ///
    /// - parameter resolver: a consumer of the future result
    public func onComplete(resolver: @escaping Consumer) {
        process(consumer: resolver)
    }
}
