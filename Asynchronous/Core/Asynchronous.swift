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
    //1,1
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

    //1,0
    public static func asyncify<I, R>(function: @escaping (I, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I) -> Async<Void> {
        let asyncified = asyncify(function: { (i: I,  o: ((), Swift.Error?) -> Void) -> R in
            function(i) { e in
                o((), e)
            }
        })
        return asyncified
    }

    //1,2
    public static func asyncify<I, O0, O1, R>(function: @escaping (I, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: I,  o: ((O0, O1), Swift.Error?) -> Void) -> R in
            function(i) { o0, o1, e in
                o((o0, o1), e)
            }
        })
        return asyncified
    }

    //1,3
    public static func asyncify<I, O0, O1, O2, R>(function: @escaping (I, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: I,  o: ((O0, O1, O2), Swift.Error?) -> Void) -> R in
            function(i) { o0, o1, o2, e in
                o((o0, o1, o2), e)
            }
        })
        return asyncified
    }

    //1,4
    public static func asyncify<I, O0, O1, O2, O3, R>(function: @escaping (I, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: I,  o: ((O0, O1, O2, O3), Swift.Error?) -> Void) -> R in
            function(i) { o0, o1, o2, o3, e in
                o((o0, o1, o2, o3), e)
            }
        })
        return asyncified
    }

    //0,0
    public static func asyncify<R>(function: @escaping (_ completionHandler: (Swift.Error?) -> Void) -> R) -> () -> Async<Void> {
        let asyncified = asyncify(function: { (_: Void,  o: (Swift.Error?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,0
    public static func asyncify<I0, I1, R>(function: @escaping (I0, I1, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,0
    public static func asyncify<I0, I1, I2, R>(function: @escaping (I0, I1, I2, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1, I2) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,0
    public static func asyncify<I0, I1, I2, I3, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,0
    public static func asyncify<I0, I1, I2, I3, I4, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,0
    public static func asyncify<I0, I1, I2, I3, I4, I5, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,0
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,0
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> Async<Void> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //0,1
    public static func asyncify<O, R>(function: @escaping (_ completionHandler: (O, Swift.Error?) -> Void) -> R) -> () -> Async<O> {
        let asyncified = asyncify(function: { (_: Void,  o: (O, Swift.Error?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,1
    public static func asyncify<I0, I1, O, R>(function: @escaping (I0, I1, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,1
    public static func asyncify<I0, I1, I2, O, R>(function: @escaping (I0, I1, I2, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1, I2) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,1
    public static func asyncify<I0, I1, I2, I3, O, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,1
    public static func asyncify<I0, I1, I2, I3, I4, O, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,1
    public static func asyncify<I0, I1, I2, I3, I4, I5, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,1
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,1
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> Async<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //--

    //0,2
    public static func asyncify<O0, O1, R>(function: @escaping (_ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> () -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (_: Void,  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,2
    public static func asyncify<I0, I1, O0, O1, R>(function: @escaping (I0, I1, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,2
    public static func asyncify<I0, I1, I2, O0, O1, R>(function: @escaping (I0, I1, I2, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1, I2) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,2
    public static func asyncify<I0, I1, I2, I3, O0, O1, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,2
    public static func asyncify<I0, I1, I2, I3, I4, O0, O1, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,2
    public static func asyncify<I0, I1, I2, I3, I4, I5, O0, O1, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,2
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O0, O1, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,2
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O0, O1, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O0, O1, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> Async<(O0, O1)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O0, O1, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //--

    //0,3
    public static func asyncify<O0, O1, O2, R>(function: @escaping (_ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> () -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (_: Void,  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,3
    public static func asyncify<I0, I1, O0, O1, O2, R>(function: @escaping (I0, I1, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,3
    public static func asyncify<I0, I1, I2, O0, O1, O2, R>(function: @escaping (I0, I1, I2, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1, I2) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,3
    public static func asyncify<I0, I1, I2, I3, O0, O1, O2, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,3
    public static func asyncify<I0, I1, I2, I3, I4, O0, O1, O2, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,3
    public static func asyncify<I0, I1, I2, I3, I4, I5, O0, O1, O2, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,3
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O0, O1, O2, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,3
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O0, O1, O2, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O0, O1, O2, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> Async<(O0, O1, O2)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O0, O1, O2, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //--

    //0,4
    public static func asyncify<O0, O1, O2, O3, R>(function: @escaping (_ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> () -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (_: Void,  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,4
    public static func asyncify<I0, I1, O0, O1, O2, O3, R>(function: @escaping (I0, I1, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,4
    public static func asyncify<I0, I1, I2, O0, O1, O2, O3, R>(function: @escaping (I0, I1, I2, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1, I2) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,4
    public static func asyncify<I0, I1, I2, I3, O0, O1, O2, O3, R>(function: @escaping (I0, I1, I2, I3, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,4
    public static func asyncify<I0, I1, I2, I3, I4, O0, O1, O2, O3, R>(function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,4
    public static func asyncify<I0, I1, I2, I3, I4, I5, O0, O1, O2, O3, R>(function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,4
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O0, O1, O2, O3, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,4
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O0, O1, O2, O3, R>(function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> Async<(O0, O1, O2, O3)> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O0, O1, O2, O3, Swift.Error?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //MARK: - Failable, shared handler, specific error
    public static func asyncify<I, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I, _ completionHandler: (O, E?) -> Void) -> R) -> (I) -> FailableAsync<O, E> {
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

    //1,0
    public static func asyncify<I, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I, _ completionHandler: (E?) -> Void) -> R) -> (I) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: I,  o: ((), E?) -> Void) -> R in
            function(i) { e in
                o((), e)
            }
        })
        return asyncified
    }

    //1,2
    public static func asyncify<I, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: I,  o: ((O0, O1), E?) -> Void) -> R in
            function(i) { o0, o1, e in
                o((o0, o1), e)
            }
        })
        return asyncified
    }

    //1,3
    public static func asyncify<I, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: I,  o: ((O0, O1, O2), E?) -> Void) -> R in
            function(i) { o0, o1, o2, e in
                o((o0, o1, o2), e)
            }
        })
        return asyncified
    }

    //1,4
    public static func asyncify<I, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: I,  o: ((O0, O1, O2, O3), E?) -> Void) -> R in
            function(i) { o0, o1, o2, o3, e in
                o((o0, o1, o2, o3), e)
            }
        })
        return asyncified
    }

    //0,0
    public static func asyncify<R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (_ completionHandler: (E?) -> Void) -> R) -> () -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (_: Void,  o: (E?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,0
    public static func asyncify<I0, I1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1),  o: (E?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,0
    public static func asyncify<I0, I1, I2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1, I2) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2),  o: (E?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,0
    public static func asyncify<I0, I1, I2, I3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1, I2, I3) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3),  o: (E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,0
    public static func asyncify<I0, I1, I2, I3, I4, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4),  o: (E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,0
    public static func asyncify<I0, I1, I2, I3, I4, I5, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5),  o: (E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,0
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,0
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> FailableAsync<Void, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //0,1
    public static func asyncify<O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (_ completionHandler: (O, E?) -> Void) -> R) -> () -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (_: Void,  o: (O, E?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,1
    public static func asyncify<I0, I1, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,1
    public static func asyncify<I0, I1, I2, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1, I2) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,1
    public static func asyncify<I0, I1, I2, I3, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1, I2, I3) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,1
    public static func asyncify<I0, I1, I2, I3, I4, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,1
    public static func asyncify<I0, I1, I2, I3, I4, I5, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,1
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,1
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> FailableAsync<O, E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //--

    //0,2
    public static func asyncify<O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (_ completionHandler: (O0, O1, E?) -> Void) -> R) -> () -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (_: Void,  o: (O0, O1, E?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,2
    public static func asyncify<I0, I1, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,2
    public static func asyncify<I0, I1, I2, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1, I2) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,2
    public static func asyncify<I0, I1, I2, I3, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1, I2, I3) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,2
    public static func asyncify<I0, I1, I2, I3, I4, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,2
    public static func asyncify<I0, I1, I2, I3, I4, I5, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,2
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,2
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O0, O1, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O0, O1, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> FailableAsync<(O0, O1), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O0, O1, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //--

    //0,3
    public static func asyncify<O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (_ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> () -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (_: Void,  o: (O0, O1, O2, E?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,3
    public static func asyncify<I0, I1, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,3
    public static func asyncify<I0, I1, I2, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1, I2) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,3
    public static func asyncify<I0, I1, I2, I3, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1, I2, I3) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,3
    public static func asyncify<I0, I1, I2, I3, I4, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,3
    public static func asyncify<I0, I1, I2, I3, I4, I5, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,3
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,3
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O0, O1, O2, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O0, O1, O2, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> FailableAsync<(O0, O1, O2), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O0, O1, O2, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

    //--

    //0,4
    public static func asyncify<O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (_ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> () -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (_: Void,  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(o)
        })
        return asyncified
    }

    //2,4
    public static func asyncify<I0, I1, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    //3,4
    public static func asyncify<I0, I1, I2, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1, I2) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    //4,4
    public static func asyncify<I0, I1, I2, I3, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1, I2, I3) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    //5,4
    public static func asyncify<I0, I1, I2, I3, I4, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    //6,4
    public static func asyncify<I0, I1, I2, I3, I4, I5, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    //7,4
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    //8,4
    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O0, O1, O2, O3, R, E: Swift.Error>(errorType: E.Type = E.self, function: @escaping (I0, I1, I2, I3, I4, I5, I6, I7, _ completionHandler: (O0, O1, O2, O3, E?) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> FailableAsync<(O0, O1, O2, O3), E> {
        let asyncified = asyncify(errorType: errorType, function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7),  o: (O0, O1, O2, O3, E?) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }

}
