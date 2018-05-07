//import Asynchronous
//import XCTest
//
//final class AsynchronousTests: XCTestCase {
//    func testAsyncifyNoErrorNoArguments() {
//        func theAnswer(completion: (Int) -> Void) {
//            completion(42)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: theAnswer)
//
//        wait { expectation in
//            asyncified().async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorOneArgument() {
//        func echo(number: Int, completion: (Int) -> Void) {
//            completion(number)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: echo)
//
//        wait { expectation in
//            asyncified(42).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorTwoArguments() {
//        func add(number1: Int, number2: Int, completion: (Int) -> Void) {
//            completion(number1 + number2)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(21, 21).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorThreeArguments() {
//        func add(number1: Int,
//                 number2: Int,
//                 number3: Int,
//                 completion: (Int) -> Void) {
//            completion(number1 + number2 + number3)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(14, 14, 14).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorFourArguments() {
//        func add(number1: Int,
//                 number2: Int,
//                 number3: Int,
//                 number4: Int,
//                 completion: (Int) -> Void) {
//            completion(number1 + number2 + number3 + number4)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(12, 11, 10, 9).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorFiveArguments() {
//        func add(number1: Int,
//                 number2: Int,
//                 number3: Int,
//                 number4: Int,
//                 number5: Int,
//                 completion: (Int) -> Void) {
//            completion(number1 + number2 + number3 + number4 + number5)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(8, 9, 8, 9, 8).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorSixArguments() {
//        func add(number1: Int,
//                 number2: Int,
//                 number3: Int,
//                 number4: Int,
//                 number5: Int,
//                 number6: Int,
//                 completion: (Int) -> Void) {
//            completion(number1 + number2 + number3 + number4 + number5 + number6)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(7, 7, 7, 7, 7, 7).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorSevenArguments() {
//        func add(number1: Int,
//                 number2: Int,
//                 number3: Int,
//                 number4: Int,
//                 number5: Int,
//                 number6: Int,
//                 number7: Int,
//                 completion: (Int) -> Void) {
//            completion(number1 + number2 + number3 + number4 + number5 + number6 + number7)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(6, 6, 6, 6, 6, 6, 6).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//
//    func testAsyncifyNoErrorEightArguments() {
//        func add(number1: Int,
//                 number2: Int,
//                 number3: Int,
//                 number4: Int,
//                 number5: Int,
//                 number6: Int,
//                 number7: Int,
//                 number8: Int,
//                 completion: (Int) -> Void) {
//            completion(number1 + number2 + number3 + number4
//                     + number5 + number6 + number7 + number8)
//        }
//
//        let asyncified = Asynchronous.asyncify(function: add)
//
//        wait { expectation in
//            asyncified(5, 5, 5, 6, 6, 5, 5, 5).async { (actual, error) in
//                XCTAssertEqual(42, actual)
//                XCTAssertNil(error)
//                expectation.fulfill()
//            }
//        }
//    }
//}
