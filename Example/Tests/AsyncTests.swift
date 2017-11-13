import Asynchronous
import XCTest

final class AsyncTests: XCTestCase {
    // MARK: - Creation
    func testCreationFromFuture_FutureSucceeds() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        let async = FailableAsync(future: future)

        wait { expectation in
            async.async { actual, error in
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testCreationFromFuture_FutureFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { resolve, reject in
            reject(expected)
        }

        let async = FailableAsync(future: future)

        wait { expectation in
            async.async { value, actual in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual)
                expectation.fulfill()
            }
        }
    }

    func testCreationFromClosure_FutureSucceeds() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        wait { expectation in
            async.async { actual, error in
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testCreationFromClosure_FutureFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            reject(expected)
        }

        wait { expectation in
            async.async { value, actual in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual)
                expectation.fulfill()
            }
        }
    }

    //MARK: - Static Cration

    func testStaticCreationFromFuture_FutureSucceeds() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { resolve, reject in
            resolve(expected)
        }

        let async = FailableAsync.from(future: future)

        wait { expectation in
            async.async { actual, error in
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testStaticCreationFromFuture_FutureFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { resolve, reject in
            reject(expected)
        }

        let async = FailableAsync.from(future: future)

        wait { expectation in
            async.async { value, actual in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual)
                expectation.fulfill()
            }
        }
    }

    func testStaticCreationFromClosure_FutureSucceeds() {
        let expected = 3
        let async = FailableAsync<Int, TestError>.from { resolver in
            //TODO: Fix unncecessary type cast
            resolver(expected, nil as TestError?)
        }

        wait { expectation in
            async.async { actual, error in
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testStaticCreationFromClosure_FutureFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError>.from { resolver in
            resolver(nil, expected)
        }

        wait { expectation in
            async.async { value, wrappedError in
                XCTAssertNil(value)
                XCTAssertNotNil(wrappedError)
                guard let unwrappedError = wrappedError else {
                    XCTFail()
                    return
                }
                switch unwrappedError {
                case .valueAndErrorNil:
                    XCTFail("Invalid error")
                case .some(let actual):
                    XCTAssertEqual(expected, actual)
                }
                expectation.fulfill()
            }
        }
    }

    //MARK: - Result

    func testResultSucceeds() {
        let expected = 3
        let async = FailableAsync<Int, TestError> { resolve, reject in
            resolve(expected)
        }

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

    func testResultFails() {
        let expected = TestError.somethingReallyHorribleHappened
        let async = FailableAsync<Int, TestError> { resolve, reject in
            reject(expected)
        }

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
