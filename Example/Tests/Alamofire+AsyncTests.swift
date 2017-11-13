import Alamofire
import Asynchronous
import Mockingjay
import XCTest

final class AlamofireAsyncTests: XCTestCase {
    let fakeURL = "http://httpbin.org/get"

    override func setUp() {
        removeAllStubs()
    }

    func testDataRequestResponseSuccess() {
        guard let expected = Data(base64Encoded: "abcdABCD") else {
            XCTFail("Invalid data string: malformed test")
            return
        }

        stub(everything, http(download: .content(expected)))

        wait { expectation in
            Alamofire.request(fakeURL).response().async { result in
                switch result {
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                case .success(let (_, response, actual)):
                    XCTAssertEqual(200, response.statusCode)
                    XCTAssertEqual(expected, actual)
                }
                expectation.fulfill()
            }
        }
    }

    func testDataRequestResponseFailure() {
        let expected = TestError.somethingReallyHorribleHappened

        stub(everything, failure(expected as NSError))

        wait { expectation in
            Alamofire.request(fakeURL).response().async { result in
                switch result {
                case .success(let (_, _, value)):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }

    func testDataRequestResponseDataSuccess() {
        guard let expected = Data(base64Encoded: "abcdABCD") else {
            XCTFail("Invalid data string: malformed test")
            return
        }

        stub(everything, http(download: .content(expected)))

        wait { expectation in
            Alamofire.request(fakeURL).responseData().async { result in
                switch result {
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                case .success(let actual):
                    XCTAssertEqual(expected, actual)
                }
                expectation.fulfill()
            }
        }
    }

    func testDataRequestResponseDataFailure() {
        let expected = TestError.somethingReallyHorribleHappened

        stub(everything, failure(expected as NSError))

        wait { expectation in
            Alamofire.request(fakeURL).responseData().async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }

    func testDataRequestResponseStringSuccess() {
        let expected = "testTestFooBarAsync"
        guard let expectedData = expected.data(using: .utf8) else {
            XCTFail("Invalid data generated: malformed test")
            return
        }

        stub(everything, http(download: .content(expectedData)))

        wait { expectation in
            Alamofire.request(fakeURL).responseString().async { result in
                switch result {
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                case .success(let actual):
                    XCTAssertEqual(expected, actual)
                }
                expectation.fulfill()
            }
        }
    }

    func testDataRequestResponseStringFailure() {
        let expected = TestError.somethingReallyHorribleHappened

        stub(everything, failure(expected as NSError))

        wait { expectation in
            Alamofire.request(fakeURL).responseString().async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }

    func testDataRequestResponseJSONSuccess() {
        let expected: [String: Any] = [
            "foo": "bar",
            "number": 1234,
            "array": [1, 2, 3, "foo"],
            "child": [
                "foo2": "bar2"
            ]
        ]

        stub(everything, json(expected))

        wait { expectation in
            Alamofire.request(fakeURL).responseJSON().async { result in
                switch result {
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                case .success(let actual):
                    let nsExpected = expected as NSDictionary
                    guard let actual = actual as? [String: Any] else {
                        XCTFail("Invalid type")
                        return
                    }
                    XCTAssertTrue(nsExpected.isEqual(to: actual))
                }
                expectation.fulfill()
            }
        }

    }

    func testDataRequestResponseJSONFailure() {
        let expected = TestError.somethingReallyHorribleHappened

        stub(everything, failure(expected as NSError))

        wait { expectation in
            Alamofire.request(fakeURL).responseJSON().async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }

    func testDownloadRequestResponseDataSuccess() {
        guard let expected = Data(base64Encoded: "abcdABCD") else {
            XCTFail("Invalid data string: malformed test")
            return
        }

        stub(everything, http(download: .content(expected)))

        wait { expectation in
            Alamofire.download(fakeURL).responseData().async { result in
                switch result {
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                case .success(let response):
                    XCTAssertEqual(200, response.response?.statusCode)
                    XCTAssertEqual(expected, response.value)
                }
                expectation.fulfill()
            }
        }
    }

    func testDownloadRequestResponseDataFailure() {
        let expected = TestError.somethingReallyHorribleHappened

        stub(everything, failure(expected as NSError))

        wait { expectation in
            Alamofire.download(fakeURL).responseData().async { result in
                switch result {
                case .success(let value):
                    XCTFail("Unexpected value \(value)")
                case .failure(let actual):
                    XCTAssertEqual(expected, actual.error as? TestError)
                }
                expectation.fulfill()
            }
        }
    }
}
