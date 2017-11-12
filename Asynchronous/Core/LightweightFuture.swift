import Foundation
import Result

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

    public typealias FutureResult = Result<T, Error>
    public typealias Consumer = (FutureResult) -> Void
    private var pendencies: [Consumer] = []
    private func process(consumer: Consumer) {
        switch state {
        case .pending:
            //Figure what to do!
            print("Attempted to process pending future")
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

    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        resolver(fulfill, reject)
    }

    private func fulfill(value: T) {
        self.state = .fulfilled(value)
    }

    private func reject(error: Error) {
        self.state = .rejected(error)
    }

    public func onComplete(resolver: @escaping Consumer) {
        switch state {
        case .pending:
            pendencies.append(resolver)
        case .fulfilled, .rejected:
            process(consumer: resolver)
        }
    }
}
