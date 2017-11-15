import Asynchronous
import XCTest

final class AsynchronousFailableSharedHandlerGenericErrorTests: XCTestCase {

    //MARK: - Succeedss
    func testZeroArgumentsZeroExtraClosureParametersSucceeds() {
        func theAnswer(completion: (Error?) -> Void) {
            //Because, is some way, not failing is succeeding
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: theAnswer)

        wait { expectation in
            asyncified().async { (actual, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsOneExtraClosureParameterSucceeds() {
        func theAnswer(completion: (Int, Error?) -> Void) {
            completion(42, nil)
        }

        let asyncified = Asynchronous.asyncify(function: theAnswer)

        wait { expectation in
            asyncified().async { (actual, error) in
                XCTAssertEqual(42, actual)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsTwoExtraClosureParametersSucceeds() {
        func theAnswer(completion: (Int, Int, Error?) -> Void) {
            completion(42, 41, nil)
        }

        let asyncified = Asynchronous.asyncify(function: theAnswer)

        wait { expectation in
            asyncified().async { (actual, error) in
                XCTAssertEqual(42, actual?.0)
                XCTAssertEqual(41, actual?.1)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsThreeExtraClosureParametersSucceeds() {
        func theAnswer(completion: (Int, Int, Int, Error?) -> Void) {
            completion(42, 41, 40, nil)
        }

        let asyncified = Asynchronous.asyncify(function: theAnswer)

        wait { expectation in
            asyncified().async { (actual, error) in
                XCTAssertEqual(42, actual?.0)
                XCTAssertEqual(41, actual?.1)
                XCTAssertEqual(40, actual?.2)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsFourExtraClosureParametersSucceeds() {
        func theAnswer(completion: (Int, Int, Int, Int, Error?) -> Void) {
            completion(42, 41, 40, 39, nil)
        }

        let asyncified = Asynchronous.asyncify(function: theAnswer)

        wait { expectation in
            asyncified().async { (actual, error) in
                XCTAssertEqual(42, actual?.0)
                XCTAssertEqual(41, actual?.1)
                XCTAssertEqual(40, actual?.2)
                XCTAssertEqual(39, actual?.3)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    //TODO: One!

    func testTwoArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let expected = [1, 2]

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(expected[0], expected[1]).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  completion: ([Int], Error?) -> Void) {
            let array = [a0, a1]
            completion(array, nil)
        }

        let expected = [1, 2]

        let asyncified = Asynchronous.asyncify(function: echo)

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

    func testTwoArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(1, 2).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      a2: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(1, 2, 3).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: ([Int], Error?) -> Void) {
            let array = [a0, a1, a2]
            completion(array, nil)
        }

        let expected = [1, 2, 3]

        let asyncified = Asynchronous.asyncify(function: echo)

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


    func testThreeArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2, 3]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2, 3]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2, 3]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(1, 2, 3, 4).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: ([Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3]
            completion(array, nil)
        }

        let expected = [1, 2, 3, 4]

        let asyncified = Asynchronous.asyncify(function: echo)

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

    func testFourArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2, 3, 4]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2, 3, 4]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2, 3, 4]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(1, 2, 3, 4, 5).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: ([Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4]
            completion(array, nil)
        }

        let expected = [1, 2, 3, 4, 5]

        let asyncified = Asynchronous.asyncify(function: echo)

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

    func testFiveArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2, 3, 4, 5]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2, 3, 4, 5]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2, 3, 4, 5]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4]).async { (value, error) in
                guard let actual = value else {
                    XCTAssertNotNil(value)
                    return
                }
                XCTAssertEqual(expected, actual.0)
                XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      a5: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(1, 2, 3, 4, 5, 6).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
            completion: ([Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5]
            completion(array, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6]

        let asyncified = Asynchronous.asyncify(function: echo)

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

    func testSixArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSixArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
            completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSixArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
            completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                        XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      a5: Int,
                      a6: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(1, 2, 3, 4, 5, 6, 7).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: ([Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6]
            completion(array, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7]

        let asyncified = Asynchronous.asyncify(function: echo)

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

    func testSevenArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                        XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testEightArgumentsZeroExtraClosureParametersSucceeds() {
        func sinkhole(a0: Int,
                      a1: Int,
                      a2: Int,
                      a3: Int,
                      a4: Int,
                      a5: Int,
                      a6: Int,
                      a7: Int,
                      completion: (Error?) -> Void) {
            completion(nil)
        }

        let asyncified = Asynchronous.asyncify(function: sinkhole)

        wait { expectation in
            asyncified(1, 2, 3, 4, 5, 6, 7, 8).async { (_, error) in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
    }

    func testEightArgumentsOneExtraClosureParameterSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: ([Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6, a7]
            completion(array, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7, 8]

        let asyncified = Asynchronous.asyncify(function: echo)

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

    func testEightArgumentsTwoExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: ([Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6, a7]
            completion(array, array.map { $0 * 2 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7, 8]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6], expected[7]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testEightArgumentsThreeExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: ([Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6, a7]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7, 8]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6], expected[7]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    func testEightArgumentsFourExtraClosureParametersSucceeds() {
        func echo(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: ([Int], [Int], [Int], [Int], Error?) -> Void) {
            let array = [a0, a1, a2, a3, a4, a5, a6, a7]
            completion(array, array.map { $0 * 2 }, array.map { $0 * 3 }, array.map { $0 * 4 }, nil)
        }

        let expected = [1, 2, 3, 4, 5, 6, 7, 8]

        let asyncified = Asynchronous.asyncify(function: echo)

        wait { expectation in
            asyncified(expected[0], expected[1], expected[2], expected[3],
                       expected[4], expected[5], expected[6], expected[7]).async { (value, error) in
                        guard let actual = value else {
                            XCTAssertNotNil(value)
                            return
                        }
                        XCTAssertEqual(expected, actual.0)
                        XCTAssertEqual(expected.map { $0 * 2 }, actual.1)
                        XCTAssertEqual(expected.map { $0 * 3 }, actual.2)
                        XCTAssertEqual(expected.map { $0 * 4 }, actual.3)
                        XCTAssertNil(error)
                        expectation.fulfill()
            }
        }
    }

    //MARK: - Fails
    func testZeroArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified().async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(
            completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified().async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(
            completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified().async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(
            completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified().async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testZeroArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(
            completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified().async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testOneArgumentFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testTwoArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testThreeArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFourArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testFiveArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSixArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testSevenArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testEightArgumentsZeroExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,completion: (Error?) -> Void) {
            completion(expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testEightArgumentsOneExtraParameterFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: (Int?, Error?) -> Void) {
            completion(nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testEightArgumentsTwoExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: (Int?, Int?, Error?) -> Void) {
            completion(nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testEightArgumentsThreeExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: (Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

    func testEightArgumentsFourExtraParametersFails() {
        let expected = TestError.somethingReallyHorribleHappened as NSError
        func fail(a0: Int,
                  a1: Int,
                  a2: Int,
                  a3: Int,
                  a4: Int,
                  a5: Int,
                  a6: Int,
                  a7: Int,
                  completion: (Int?, Int?, Int?, Int?, Error?) -> Void) {
            completion(nil, nil, nil, nil, expected)
        }

        let asyncified = Asynchronous.asyncify(function: fail)

        wait { expectation in
            asyncified(0, 0, 0, 0, 0, 0, 0, 0).async { (value, actual) in
                XCTAssertNil(value)
                XCTAssertEqual(expected, actual?.error as NSError?)
                expectation.fulfill()
            }
        }
    }

}
