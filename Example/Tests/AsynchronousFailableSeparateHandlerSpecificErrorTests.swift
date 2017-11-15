import Asynchronous
import XCTest

final class AsynchronousFailableSeparateHandlerSpecificErrorTests: XCTestCase {

    //MARK: - Succeedss
    func testZeroArgumentSucceeds() {
        func theAnswer(completion: (Int) -> Void,
                       error: (TestError) -> Void) {
            completion(42)
        }

        //TODO: Find a way of removing `errorType` from call
        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: theAnswer)

        wait { expectation in
            asyncified().async { (actual, error) in
                XCTAssertEqual(42, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentSucceeds() {
        func echo(a0: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0])
        }

        let expected = [0]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1])
        }

        let expected = [0, 1]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1, a2])
        }

        let expected = [0, 1, 2]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1, a2, a3])
        }

        let expected = [0, 1, 2, 3]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1, a2, a3, a4])
        }

        let expected = [0, 1, 2, 3, 4]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSixArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1, a2, a3, a4, a5])
        }

        let expected = [0, 1, 2, 3, 4, 5]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1, a2, a3, a4, a5, a6])
        }

        let expected = [0, 1, 2, 3, 4, 5, 6]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testEightArgumentsSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: ([Int]) -> Void,
                  error: (TestError) -> Void) {
            completion([a0, a1, a2, a3, a4, a5, a6, a7])
        }

        let expected = [0, 1, 2, 3, 4, 5, 6, 7]

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6], expected[7]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    //MARK: - Fails
    func testZeroArgumentsFails() {
        let expected = TestError.somethingReallyHorribleHappened
        func fail(completion: (Int) -> Void,
                  error: (TestError) -> Void) {
            error(expected)
        }

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

        wait { expectation in
            asyncified().async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentFails() {
        let expected = TestError.somethingReallyHorribleHappened
        func fail(a0: Int,
                  completion: (Int) -> Void,
                  error: (TestError) -> Void) {
            error(expected)
        }

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

        wait { expectation in
            asyncified(0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentFails() {
        let expected = TestError.somethingReallyHorribleHappened
        func fail(a0: Int,
                  a1: Int,
                  completion: (Int) -> Void,
                  error: (TestError) -> Void) {
            error(expected)
        }

        let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

        wait { expectation in
            asyncified(0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual)
                expectation.fulfill()
            }
        }

        func testThreeArgumentFails() {
            let expected = TestError.somethingReallyHorribleHappened
            func fail(a0: Int,
                      a1: Int,
                      a2: Int,
                      completion: (Int) -> Void,
                      error: (TestError) -> Void) {
                error(expected)
            }

            let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

            wait { expectation in
                asyncified(0, 0, 0).async { (value, actual) in
                    XCTAssertNil(value)
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }
            }
        }

        func testFourArgumentFails() {
            let expected = TestError.somethingReallyHorribleHappened
            func fail(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      completion: (Int) -> Void,
                      error: (TestError) -> Void) {
                error(expected)
            }

            let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

            wait { expectation in
                asyncified(0, 0, 0, 0).async { (value, actual) in
                    XCTAssertNil(value)
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }
            }
        }

        func testFiveArgumentFails() {
            let expected = TestError.somethingReallyHorribleHappened
            func fail(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      completion: (Int) -> Void,
                      error: (TestError) -> Void) {
                error(expected)
            }

            let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

            wait { expectation in
                asyncified(0, 0, 0, 0, 0).async { (value, actual) in
                    XCTAssertNil(value)
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }
            }
        }

        func testSixArgumentFails() {
            let expected = TestError.somethingReallyHorribleHappened
            func fail(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      a5: Int,
                      completion: (Int) -> Void,
                      error: (TestError) -> Void) {
                error(expected)
            }

            let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

            wait { expectation in
                asyncified(0, 0, 0, 0, 0, 0).async { (value, actual) in
                    XCTAssertNil(value)
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }
            }
        }

        func testSevenArgumentFails() {
            let expected = TestError.somethingReallyHorribleHappened
            func fail(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      a5: Int,
                      a6: Int,
                      completion: (Int) -> Void,
                      error: (TestError) -> Void) {
                error(expected)
            }

            let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

            wait { expectation in
                asyncified(0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                    XCTAssertNil(value)
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }
            }
        }
        func testEightArgumentFails() {
            let expected = TestError.somethingReallyHorribleHappened
            func fail(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      a5: Int,
                      a6: Int,
                      a7: Int,
                      completion: (Int) -> Void,
                      error: (TestError) -> Void) {
                error(expected)
            }

            let asyncified = Asynchronous.asyncify(errorType: TestError.self, function: fail)

            wait { expectation in
                asyncified(0, 0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                    XCTAssertNil(value)
                    XCTAssertEqual(expected, actual)
                    expectation.fulfill()
                }
            }
        }
    }
}

