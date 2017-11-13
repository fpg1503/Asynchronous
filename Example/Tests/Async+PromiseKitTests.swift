import Asynchronous
import PromiseKit
import Result
import XCTest

//Otherwise Swift compiler gets confused, won't happen if the
//the user doesn't have several promises with the same interface
typealias PromiseKitPromise = Promise

final class AsyncPromiseKitTests: XCTestCase {
    //MARK: - Async -> PromiseKit
    func testSynchronousResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        wait { expectation in
            (async.promise() as PromiseKitPromise).then { actual in
                XCTAssertEqual(expected, actual)
            }.catch { error in
                XCTFail("Unexpected error \(error)")
            }.always {
                expectation.fulfill()
            }
        }
    }

    func testSynchronousReject() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            reject(expected)
        }

        wait { expectation in
            (async.promise() as PromiseKitPromise).then { value in
                XCTFail("Unexpected value \(value)")
            }.catch { actual in
                XCTAssertEqual(expected, actual as? TestError)
            }.always {
                expectation.fulfill()
            }
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
            (async.promise() as PromiseKitPromise).then { actual in
                XCTAssertEqual(expected, actual)
            }.catch { error in
                XCTFail("Unexpected error \(error)")
            }.always {
                expectation.fulfill()
            }
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
            (async.promise() as PromiseKitPromise).then { value in
                XCTFail("Unexpected value \(value)")
            }.catch { actual in
                XCTAssertEqual(expected, actual as? TestError)
            }.always {
                expectation.fulfill()
            }
        }
    }
    //MARK: - BrightFutures -> PromiseKit

    func testPromiseKitConversion_AsyncSucceeds() {
        let expected = 3
        let promise = Promise<Int> { resolve, reject in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                let _ = resolve(expected)
            }
        }

        let async = Async.from(promise: promise)

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

    func testPromiseKitConversion_AsyncFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let promise = Promise<Int> { resolve, reject in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                let _ = reject(expected)
            }
        }

        let async = Async.from(promise: promise)

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
