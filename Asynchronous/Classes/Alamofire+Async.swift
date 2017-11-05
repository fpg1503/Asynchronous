import Alamofire
import Foundation
import Result

extension DataRequest {
    public func response(queue: DispatchQueue? = nil) -> Async<(URLRequest, HTTPURLResponse, Data)> {
        return Async { resolve, reject in
            response(queue: queue) { response in
                if let error = response.error {
                    reject(AnyError(error))
                } else if let request = response.request,
                    let httpResponse = response.response,
                    let data = response.data {
                    resolve((request, httpResponse, data))
                } else {
                    reject(AnyError(AsyncError<AnyError>.valueAndErrorNil))
                }
            }
        }
    }
    
    public func responseData(queue: DispatchQueue? = nil) -> Async<Data> {
        return Async { resolve, reject in
            responseData(queue: queue) { response in
                switch response.result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(AnyError(error))
                }
            }
        }
    }
    
    public func responseString(queue: DispatchQueue? = nil) -> Async<String> {
        return Async { resolve, reject in
            responseString(queue: queue) { response in
                switch response.result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(AnyError(error))
                }
            }
        }
    }
    
    public func responseJSON(queue: DispatchQueue? = nil,
                             options: JSONSerialization.ReadingOptions = .allowFragments) -> Async<Any> {
        return Async { resolve, reject in
            responseJSON(queue: queue, options: options) { response in
                switch response.result {
                case .success(let value):
                    resolve(value)
                case .failure(let error):
                    reject(AnyError(error))
                }
            }
        }
    }
}

extension DownloadRequest {
    public func responseData(queue: DispatchQueue? = nil) -> Async<DownloadResponse<Data>> {
        return Async { resolve, reject in
            responseData(queue: queue) { response in
                switch response.result {
                case .success:
                    resolve(response)
                case .failure(let error):
                    reject(AnyError(error))
                }
            }
        }
    }
}
