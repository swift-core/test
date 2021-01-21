public func expect(
    _ expression: Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line)
{
    test.registerExpectation()
    guard expression else {
        fail(message(), file: file, line: line)
        return
    }
}

public func expect<Error: Swift.Error, Result>(
    throws error: Error,
    _ message: @autoclosure @escaping () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ expression: @escaping () async throws -> Result
) where Error: Equatable {
    test.registerExpectation()
    runAsyncAndBlock {
        do {
            _ = try await expression()
            fail(message(), file: file, line: line)
        } catch let _error {
            guard let __error = _error as? Error else {
                fail(
                    "expected: \(Error.self), throwed: \(type(of: _error))",
                    file: file,
                    line: line)
                return
            }
            guard error == __error else {
                fail(message(), file: file, line: line)
                return
            }
        }
    }
}

public func fail(
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line)
{
    test.fail(.handled(.init(message: message(), file: file, line: line)))
}
