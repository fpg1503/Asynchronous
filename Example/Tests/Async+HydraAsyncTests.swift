import Asynchronous
import Hydra
import Result
import XCTest

class AsyncHydraAsyncTests: XCTestCase {
    //MARK: - Async -> Hydra
    func testSynchronousResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        wait { expectation in
            async.hydra().then { actual in
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
            async.hydra().then { value in
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
            async.hydra().then { actual in
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
            async.hydra().then { value in
                XCTFail("Unexpected value \(value)")
            }.catch { actual in
                XCTAssertEqual(expected, actual as? TestError)
            }.always {
                expectation.fulfill()
            }
        }
    }
    //MARK: - BrightFutures -> Hydra

    func testHydraConversion_AsyncSucceeds() {
        let expected = 3
        let hydra = Promise { resolve, reject, _ in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                resolve(expected)
            }
        }

        let async = Async.from(promise: hydra)

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

    func testHydraConversion_AsyncFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let hydra = Promise<Int> { resolve, reject, _ in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                let _ = reject(expected)
            }
        }

        let async = Async.from(promise: hydra)

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

