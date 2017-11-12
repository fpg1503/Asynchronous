import Foundation
import Result

public enum AsyncError<T: Error>: Error {
    case valueAndErrorNil
    case some(T)
}

public final class LightweightFuture<T, Error: Swift.Error> {
    enum State<T, Error: Swift.Error> {
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
    
    typealias FutureResult = Result<T, Error>
    typealias Consumer = (FutureResult) -> Void
    private var pendencies: [Consumer] = []
    func process(consumer: Consumer) {
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
                    print("Invalid transition from \(oldValue) to \(state)")
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
    
    func onComplete(resolver: @escaping Consumer) {
        switch state {
        case .pending:
            pendencies.append(resolver)
        case .fulfilled, .rejected:
            process(consumer: resolver)
        }
    }
    
}

public typealias Async<T> = FailableAsync<T, AnyError>
public typealias InfailableAsync<T> = FailableAsync<T, NoError>

public struct FailableAsync<T, Error: Swift.Error> {

    public let backingFuture: LightweightFuture<T, Error>

    public init(future: LightweightFuture<T, Error>) {
        self.backingFuture = future
    }

    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        
        self.backingFuture = LightweightFuture { (resolve, reject) in
            resolver(resolve, reject)
        }
    }

    public static func from(future: LightweightFuture<T, Error>) -> FailableAsync<T, Error> {
        return FailableAsync(future: future)
    }

    public static func from<SomeError: Swift.Error>(_ resolver: @escaping (_ completion: (T?, SomeError?) -> Void) -> Void) -> FailableAsync<T, AsyncError<SomeError>> {
        return FailableAsync<T, AsyncError<SomeError>> { resolve, reject in
            resolver { (value, error) in
                if let value = value {
                    resolve(value)
                } else if let error = error {
                    reject(.some(error))
                } else {
                    reject(.valueAndErrorNil)
                }
            }
        }
    }

    public func async(_ completion: @escaping (T?, Error?) -> Void) {
        backingFuture.onComplete { (result) in
            completion(result.value, result.error)
        }
    }

    public func async(_ completion: @escaping (Result<T, Error>) -> Void) {
        backingFuture.onComplete { (result) in
            completion(result)
        }
    }
}

