import Asynchronous
import Result
import RxSwift
import XCTest

final class AsyncRxTests: XCTestCase {

    //MARK: - Async -> Rx
    func testSynchronousResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        wait { expectation in
            async.asSingle()
                .subscribe(onSuccess: { actual in
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }, onError: { error in
                    XCTFail("Unexpected error \(error)")
                    expectation.fulfill()
                })
        }
    }
    
    func testSynchronousObservableResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }
        
        wait { expectation in
            async.asObservable()
                .subscribe(onNext: { actual in
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                })
        }
    }
    
    func testSynchronousReject() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            reject(expected)
        }
        
        wait { expectation in
            async.asSingle()
                .subscribe(onSuccess: { value in
                    XCTFail("Unexpected value \(value)")
                    expectation.fulfill()
                }, onError: { actual in
                    XCTAssertEqual(expected, actual as? TestError)
                    expectation.fulfill()
                })
        }
    }
    
    func testSynchronousObservableReject() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            reject(expected)
        }
        
        wait { expectation in
            async.asObservable()
                .subscribe(onError: { actual in
                    XCTAssertEqual(expected, actual as? TestError)
                    expectation.fulfill()
                })
        }
    }
    
    func testAsynchronousResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                resolve(expected)
            }
        }
        
        wait { expectation in
            async.asSingle()
                .subscribe(onSuccess: { actual in
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }, onError: { error in
                    XCTFail("Unexpected error \(error)")
                    expectation.fulfill()
                })
        }
    }
    
    func testAsynchronousReject() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                reject(expected)
            }
        }
        
        wait { expectation in
            async.asSingle()
                .subscribe(onSuccess: { value in
                    XCTFail("Unexpected value \(value)")
                    expectation.fulfill()
                }, onError: { actual in
                    XCTAssertEqual(expected, actual as? TestError)
                    expectation.fulfill()
                })
        }
    }
    
    //MARK: - Rx -> Async
    func testRxSingleConversion_AsyncSucceeds() {
        let expected = 3
        let single = Single<Int>.create { single in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                single(.success(expected))
            }

            return Disposables.create()
        }
        
        let async = Async.from(single: single)
        
        wait { expectation in
            async.async { result in
                switch result {
                case .success(let actual):
                    XCTAssertEqual(expected, actual)
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                }
                expectation.fulfill()
            }
        }
    }
    
    func testRxObservableConversion_AsyncSucceeds() {
        let expected = 3
        let observable = Observable<Int>.create { observer in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                observer.on(.next(expected))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        
        let async = Async.from(observable: observable)
        
        wait { expectation in
            async.async { result in
                switch result {
                case .success(let actual):
                    XCTAssertEqual(expected, actual)
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                }
                expectation.fulfill()
            }
        }
    }
    
    func testRxSingleConversion_AsyncFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let single = Single<Int>.create { single in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                single(.error(expected))
            }
            
            return Disposables.create()
        }
        
        let async = Async.from(single: single)
        
        wait { expectation in
            async.async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }
    
    func testRxObservableConversion_AsyncFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let observable = Observable<Int>.create { observer in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                observer.on(.error(expected))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        
        let async = Async.from(observable: observable)
        
        wait { expectation in
            async.async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }
}

