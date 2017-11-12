import Foundation
import Result

public enum AsyncError<T: Error>: Error {
    case valueAndErrorNil
    case some(T)
}

public final class Future<T, Error: Swift.Error> {
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
    
    func onComplete(result: @escaping Consumer) {
        switch state {
        case .pending:
            pendencies.append(result)
        case .fulfilled, .rejected:
            process(consumer: result)
        }
    }
    
}

public typealias Async<T> = FailableAsync<T, AnyError>
public typealias InfailableAsync<T> = FailableAsync<T, NoError>

public struct FailableAsync<T, Error: Swift.Error> {

    public let future: Future<T, Error>

    public init(future: Future<T, Error>) {
        self.future = future
    }

    public init(resolver: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void) {
        
        self.future = Future { (resolve, reject) in
            resolver(resolve, reject)
        }
    }

    public static func from(future: Future<T, Error>) -> FailableAsync<T, Error> {
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
        future.onComplete { (result) in
            completion(result.value, result.error)
        }
    }

    public func async(_ completion: @escaping (Result<T, Error>) -> Void) {
        future.onComplete { (result) in
            completion(result)
        }
    }
}

