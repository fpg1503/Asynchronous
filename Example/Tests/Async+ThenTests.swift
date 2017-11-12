import Asynchronous
import Result
import then
import XCTest


class AsyncthenTests: XCTestCase {

    //MARK: - Async -> then
    func testSynchronousResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        wait { expectation in
            async.then().then { actual in
                XCTAssertEqual(expected, actual)
            }.onError { error in
                XCTFail("Unexpected error \(error)")
            }.finally {
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
            async.then().then { value in
                XCTFail("Unexpected value \(value)")
            }.onError { actual in
                XCTAssertEqual(expected, actual as? TestError)
            }.finally {
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
            async.then().then { actual in
                XCTAssertEqual(expected, actual)
            }.onError { error in
                XCTFail("Unexpected error \(error)")
            }.finally {
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
            async.then().then { value in
                XCTFail("Unexpected value \(value)")
            }.onError { actual in
                XCTAssertEqual(expected, actual as? TestError)
            }.finally {
                expectation.fulfill()
            }
        }
    }

    //MARK: - BrightFutures -> then
    func testthenConversion_AsyncSucceeds() {
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

    func testthenConversion_AsyncFails() {
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

