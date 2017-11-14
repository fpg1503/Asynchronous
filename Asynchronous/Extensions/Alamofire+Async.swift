import Alamofire
import Foundation
import Result

/// Add `Async` generation to *Alamofire*'s `DataRequest`.
extension DataRequest {
    /// Returns an `Async` that encapsulates a response of the
    /// underlying `URLSessionDataTask`.
    ///
    /// - Returns: An `Async` that encapsulates a response of the
    /// underlying `URLSessionDataTask`.
    public func response() -> Async<(URLRequest, HTTPURLResponse, Data)> {
        return Async { resolve, reject in
            self.response { response in
                if let error = response.error {
                    reject(error)
                } else if let request = response.request,
                    let httpResponse = response.response,
                    let data = response.data {
                    resolve((request, httpResponse, data))
                } else {
                    reject(AsyncError<AnyError>.valueAndErrorNil)
                }
            }
        }
    }

    /// Returns an `Async` that encapsulates a data response of the
    /// underlying `URLSessionDataTask`.
    ///
    /// - Returns: An `Async` that encapsulates a data response of the
    /// underlying `URLSessionDataTask`.
    public func responseData() -> Async<Data> {
        return Async { resolve, reject in
            self.responseData { response in
                switch response.result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }

    /// Returns an `Async` that encapsulates a string response of the
    /// underlying `URLSessionDataTask`.
    ///
    /// - Returns: An `Async` that encapsulates a string response of the
    /// underlying `URLSessionDataTask`.
    public func responseString() -> Async<String> {
        return Async { resolve, reject in
            self.responseString { response in
                switch response.result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }

    /// Returns an `Async` that encapsulates a JSON response of the
    /// underlying `URLSessionDataTask`.
    ///
    /// - Parameters:
    ///     - options: The JSON serialization reading options.
    /// Defaults to `.allowFragments`.
    /// - Returns: An `Async` that encapsulates a JSON response of the
    /// underlying `URLSessionDataTask`.
    public func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Async<Any> {
        return Async { resolve, reject in
            self.responseJSON(options: options) { response in
                switch response.result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}

/// Add `Async` generation to *Alamofire*'s `DownloadRequest`.
extension DownloadRequest {
    /// Returns an `Async` that encapsulates a data response of the
    /// underlying `URLSessionDownloadTask`.
    ///
    /// - Returns: An `Async` that encapsulates a data response of the
    /// underlying `URLSessionDownloadTask`.
    public func responseData() -> Async<DownloadResponse<Data>> {
        return Async { resolve, reject in
            self.responseData { response in
                switch response.result {
                case .success:
                    resolve(response)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
