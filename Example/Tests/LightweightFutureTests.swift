import Asynchronous
import XCTest

final class LightweightFutureTests: XCTestCase {
    
    func testSynchronousResolve() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            resolve(expected)
        }

        wait { expectation in
            future.onComplete { result in
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
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            reject(expected)
        }
        wait { expectation in
            future.onComplete { result in
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
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                resolve(expected)
            }
        }
        wait { expectation in
            future.onComplete { result in
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
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                reject(expected)
            }
        }
        wait { expectation in
            future.onComplete { result in
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
    
    func testSynchronousResolveThenSynchronousReject() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            resolve(expected)
            reject(.somethingReallyHorribleHappened)
        }
        wait { expectation in
            future.onComplete { result in
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
    
    func testSynchronousResolveThenAsynchronousReject() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            resolve(expected)
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                reject(.somethingReallyHorribleHappened)
            }
        }
        wait { expectation in
            future.onComplete { result in
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
    
    func testAsynchronousResolveThenAsynchronousReject() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                resolve(expected)
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                    reject(.somethingReallyHorribleHappened)
                }
            }
        }
        wait { expectation in
            future.onComplete { result in
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
    
    func testAsynchronousResolveThenSynchronousReject() {
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                resolve(expected)
                reject(.somethingReallyHorribleHappened)
            }
        }
        wait { expectation in
            future.onComplete { result in
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


    func testSynchronousRejectThenSynchronousResolve() {
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            reject(expected)
            resolve(-123)
        }
        wait { expectation in
            future.onComplete { result in
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

    func testSynchronousRejectThenAsynchronousResolve() {
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            reject(expected)
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                resolve(-123)
            }
        }
        wait { expectation in
            future.onComplete { result in
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

    func testAsynchronousRejectThenAsynchronousResolve() {
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                reject(expected)
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                    resolve(-123)
                }
            }
        }
        wait { expectation in
            future.onComplete { result in
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

    func testAsynchronousRejectThenSynchronousResolve() {
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + TestHelper.delayTime) {
                reject(expected)
                resolve(-123)
            }
        }
        wait { expectation in
            future.onComplete { result in
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

