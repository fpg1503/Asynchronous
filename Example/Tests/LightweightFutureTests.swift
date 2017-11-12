@testable import Asynchronous
import XCTest

enum TestError: String, Error {
    case somethingReallyHorribleHappened
}

class LightweightFutureTests: XCTestCase {
    private let waitTime: TimeInterval = 5
    private let delayTime: TimeInterval = 2
    
    func testSynchronousResolve() {
        let expectation = XCTestExpectation()
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            resolve(expected)
        }
        future.onComplete { result in
            switch result {
            case .success(let actual):
                XCTAssertEqual(expected, actual)
            case .failure(let error):
                XCTFail("Unexpected error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testSynchronousReject() {
        let expectation = XCTestExpectation()
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            reject(expected)
        }
        future.onComplete { result in
            switch result {
            case .success(let value):
                XCTFail("Unexpected value \(value)")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testAsynchronousResolve() {
        let expectation = XCTestExpectation()
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                resolve(expected)
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let actual):
                XCTAssertEqual(expected, actual)
            case .failure(let error):
                XCTFail("Unexpected error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testAsynchronousReject() {
        let expectation = XCTestExpectation()
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                reject(expected)
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let value):
                XCTFail("Unexpected value \(value)")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testSynchronousResolveThenSynchronousReject() {
        let expectation = XCTestExpectation()
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            resolve(expected)
            reject(.somethingReallyHorribleHappened)
        }
        future.onComplete { result in
            switch result {
            case .success(let actual):
                XCTAssertEqual(expected, actual)
            case .failure(let error):
                XCTFail("Unexpected error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testSynchronousResolveThenAsynchronousReject() {
        let expectation = XCTestExpectation()
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            resolve(expected)
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                reject(.somethingReallyHorribleHappened)
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let actual):
                XCTAssertEqual(expected, actual)
            case .failure(let error):
                XCTFail("Unexpected error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testAsynchronousResolveThenAsynchronousReject() {
        let expectation = XCTestExpectation()
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                resolve(expected)
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + self.delayTime) {
                    reject(.somethingReallyHorribleHappened)
                }
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let actual):
                XCTAssertEqual(expected, actual)
            case .failure(let error):
                XCTFail("Unexpected error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
    
    func testAsynchronousResolveThenSynchronousReject() {
        let expectation = XCTestExpectation()
        let expected = 3
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                resolve(expected)
                reject(.somethingReallyHorribleHappened)
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let actual):
                XCTAssertEqual(expected, actual)
            case .failure(let error):
                XCTFail("Unexpected error \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }


    func testSynchronousRejectThenSynchronousResolve() {
        let expectation = XCTestExpectation()
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            reject(expected)
            resolve(-123)
        }
        future.onComplete { result in
            switch result {
            case .success(let value):
                XCTFail("Unexpected value \(value)")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }

    func testSynchronousRejectThenAsynchronousResolve() {
        let expectation = XCTestExpectation()
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            reject(expected)
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                resolve(-123)
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let value):
                XCTFail("Unexpected value \(value)")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }

    func testAsynchronousRejectThenAsynchronousResolve() {
        let expectation = XCTestExpectation()
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                reject(expected)
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + self.delayTime) {
                    resolve(-123)
                }
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let value):
                XCTFail("Unexpected value \(value)")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }

    func testAsynchronousRejectThenSynchronousResolve() {
        let expectation = XCTestExpectation()
        let expected = TestError.somethingReallyHorribleHappened
        let future = LightweightFuture<Int, TestError> { (resolve, reject) in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
                reject(expected)
                resolve(-123)
            }
        }
        future.onComplete { result in
            switch result {
            case .success(let value):
                XCTFail("Unexpected value \(value)")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitTime)
    }
}

