@testable import Asynchronous
import XCTest

enum TestError: String, Error {
    case somethingReallyHorribleHappened
}

class LightweightFutureTests: XCTestCase {
    private let waitTime: TimeInterval = 5
    private let delayTime: TimeInterval = 3
    
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
}
