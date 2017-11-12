import Asynchronous
import BrightFutures
import Result
import XCTest

class AsyncBrightFuturesTests: XCTestCase {
    //MARK: - Async -> BrightFutures
    func testSynchronousResolve() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        wait { expectation in
            async.future().onComplete { result in
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

    func testSynchronousReject() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            reject(expected)
        }
        wait { expectation in
            async.future().onComplete { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual)
                }
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
            async.future().onComplete { result in
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

    func testAsynchronousReject() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                reject(expected)
            }
        }
        wait { expectation in
            async.future().onComplete { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual)
                }
                expectation.fulfill()
            }
        }
    }
    //MARK: - BrightFutures -> Async

    func testBrightFuturesConversion_AsyncSucceeds() {
        let expected = 3
        let result = Result<Int, TestError>(value: expected)
        let future = Future(result: result, delay: .seconds(Int(TestHelper.delayTime)))

        let async = FailableAsync.from(future: future)

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

    func testBrightFuturesConversion_AsyncFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let result = Result<Int, TestError>(error: expected)
        let future = Future(result: result, delay: .seconds(Int(TestHelper.delayTime)))

        let async = FailableAsync.from(future: future)

        wait { expectation in
            async.async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual)
                }
                expectation.fulfill()
            }
        }
    }

}
