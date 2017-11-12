import XCTest

struct TestHelper {
    public static let delayTime: TimeInterval = 2
    fileprivate static let defaultWaitTime: TimeInterval = 5
}

extension XCTestCase {
    func wait(waitTime: TimeInterval = TestHelper.defaultWaitTime,
              description: String = "no description provided",
              block: (XCTestExpectation) -> Void) {
        let expectation = XCTestExpectation(description: description)
        block(expectation)
        wait(for: [expectation], timeout: waitTime)
    }
}
