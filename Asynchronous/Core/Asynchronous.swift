public struct Asynchronous {
    //MARK: - Infailable

    //TODO: Docs!
    public static func asyncify<I, O, R>(function: @escaping (I, _ completionHandler: (O) -> ()) -> R) -> (I) -> InfailableAsync<O> {
        return { input in
            return InfailableAsync { resolve, _ in
                let _ = function(input) { output in
                    resolve(output)
                }
            }
        }
    }

    public static func asyncify<O, R>(function: @escaping (_ completionHandler: (O) -> Void) -> R) -> () -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (_: Void, o: (O) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, O, R>(function: @escaping (I0, I1, _ completionHandler: (O) -> Void) -> R) -> (I0, I1) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1), o: (O) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, O, R>(function: @escaping (I0, I1, I2, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, O, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, O, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //MARK: - Failable, separate handler, generic error
    public static func asyncify<I, O, R>(function: @escaping (I, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I) -> Async<O> {
        return { input in
            return Async { resolve, reject in
                let _ = function(input, { output in
                    resolve(output)
                }, { error in
                    reject(error)
                })
            }
        }
    }

    public static func asyncify<O, R>(function: @escaping (_ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> () -> Async<O> {
        let asyncified = asyncify(function: { (_: Void, o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, O, R>(function: @escaping (I0, I1, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, O, R>(function: @escaping (I0, I1, I2, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1, I2) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, i.2, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, O, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1, I2, I3) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, O, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O) -> Void, _ errorHandler: (Swift.Error) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7), o: (O) -> Void, e: (Swift.Error) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o, e)
        })
        return asyncified
    }

    //MARK: - Failable, separate handler, specific error
    public static func asyncify<I, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I) -> FailableAsync<O, E> {
        return { input in
            return FailableAsync { resolve, reject in
                let _ = function(input, { output in
                    resolve(output)
                }, { error in
                    reject(error)
                })
            }
        }
    }

    public static func asyncify<O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (_ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> () -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (_: Void, o: (O) -> Void, e: (E) -> Void) -> R in
            function(o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1, I2) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, i.2, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1, I2, I3) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o, e)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O) -> Void, _ errorHandler: (E) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7), o: (O) -> Void, e: (E) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o, e)
        })
        return asyncified
    }
    
    //MARK: - Failable, shared handler, generic error
    public static func asyncify<I, O, R>(function: @escaping (I, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I) -> Async<O> {
        return { input in
            return Async { resolve, reject in
                let _ = function(input, { output, error in
                    if let error = error {
                        reject(error)
                    } else {
                        resolve(output)
                    }
                })
            }
        }
    }

    //TODO: More!

    //MARK: - Failable, shared handler, specific error
    public static func asyncify<I, O, R, E: Swift.Error>(function: @escaping (I, _ completionHandler: (O, E?) -> Void) -> R) -> (I) -> FailableAsync<O, E> {
        return { input in
            return FailableAsync { resolve, reject in
                let _ = function(input, { output, error in
                    if let error = error {
                        reject(error)
                    } else {
                        resolve(output)
                    }
                })
            }
        }
    }

}
