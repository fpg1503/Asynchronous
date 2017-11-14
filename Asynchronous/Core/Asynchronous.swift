public struct Asynchronous {
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

    public static func asyncify<I0, I1, O, R>(function: @escaping (_: I0, _: I1, _ completionHandler: (O) -> Void) -> R) -> (I0, I1) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1), o: (O) -> Void) -> R in
            function(i.0, i.1, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, O, R>(function: @escaping (_: I0, _: I1, _: I2, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, O, R>(function: @escaping (_: I0, _: I1, _: I2, _: I3, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, O, R>(function: @escaping (_: I0, _: I1, _: I2, _: I3, _: I4, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, O, R>(function: @escaping (_: I0, _: I1, _: I2, _: I3, _: I4, _: I5, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, O, R>(function: @escaping (_: I0, _: I1, _: I2, _: I3, _: I4, _: I5, _: I6, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, o)
        })
        return asyncified
    }

    public static func asyncify<I0, I1, I2, I3, I4, I5, I6, I7, O, R>(function: @escaping (_: I0, _: I1, _: I2, _: I3, _: I4, _: I5, _: I6, _: I7, _ completionHandler: (O) -> Void) -> R) -> (I0, I1, I2, I3, I4, I5, I6, I7) -> InfailableAsync<O> {
        let asyncified = asyncify(function: { (i: (I0, I1, I2, I3, I4, I5, I6, I7), o: (O) -> Void) -> R in
            function(i.0, i.1, i.2, i.3, i.4, i.5, i.6, i.7, o)
        })
        return asyncified
    }
}
