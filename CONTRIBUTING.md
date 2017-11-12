# Contributing

All contributions are welcome!

- **Doubts? Problems?** [Open an issue](https://github.com/fpg1503/Asynchronous/issues/new)
- **Improvements? Bug fixes?** [Open a PR](https://github.com/fpg1503/Asynchronous/compare)

## Adding new extensions (async abstractions)
- Create a new subspec for your extension
- Add a method to create your abstraction with its unique name (i.e. `promiseKit()` for `PromiseKit`)
- Add a method to create your abstraction with the concept name (i.e. `promise()` for `PromiseKit`) that forwards the call to the method you created before
- Add a static method to create `Async`s fromm your abstraction (i.e. `from(promise: Promise<T>)` for `PromiseKit`)
- Add tests to cover your implementation (if you don't know how to do it open a PR anyway and we'll help you)
- Don't forget to check the target membership of your source files (there should be only two: `Async+<YourAbstraction>.swift` and `Async+<YourAbstraction>Tests.swift`)
- Document the public interface of your implementation
- Add the information to README.md

## License
All written code is MIT, when you create your PR you're saying you understand that and you allow commercial use, modification, distribution and private use.