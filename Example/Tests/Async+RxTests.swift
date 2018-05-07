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
}

