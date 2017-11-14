/// An enum representing every possible error for errors returned by Async
/// An `AsyncError` can also wrap an external error (e.g. coming from a user defined future)
/// in its `some` case. `AsyncError` has the type of the external error as its generic parameter.
public enum AsyncError<T: Error>: Error {
    /// Describes a illegal state when a user provides both value
    /// and error `nil`.
    case valueAndErrorNil

    /// Wraps a generic Swift.Error instance.
    case some(T)
}
