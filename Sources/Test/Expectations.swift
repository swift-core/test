extension Test {
    func expect(
        _ expression: Bool,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line)
    {
        registerExpectation()
        guard expression else {
            fail(message(), file: file, line: line)
            return
        }
    }

    func expect<Error: Swift.Error, Result>(
        throws error: Error,
        file: StaticString = #file,
        line: UInt = #line,
        _ expression: @escaping () async throws -> Result
    ) async where Error: Equatable {
        registerExpectation()
        do {
            _ = try await expression()
            handleError(
                expected: error,
                throwed: nil,
                file: file,
                line: line)
        } catch let throwed {
            handleError(
                expected: error,
                throwed: throwed,
                file: file,
                line: line)
        }
    }

    func expect<Error: Swift.Error, Result>(
        throws error: Error,
        file: StaticString = #file,
        line: UInt = #line,
        _ expression: @escaping () throws -> Result
    ) where Error: Equatable {
        registerExpectation()
        do {
            _ = try expression()
            handleError(
                expected: error,
                throwed: nil,
                file: file,
                line: line)
        } catch let throwed {
            handleError(
                expected: error,
                throwed: throwed,
                file: file,
                line: line)
        }
    }

    func fail(
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line)
    {
        fail(.handled(.init(
            message: message(),
            file: file,
            line: line)))
    }

    private func handleError<Error>(
        expected: Error,
        throwed: Swift.Error?,
        file: StaticString,
        line: UInt
    ) where Error: Swift.Error, Error: Equatable {
        guard let throwed = throwed else {
            fail(
                "expected: \(Error.self)",
                file: file,
                line: line)
            return
        }
        guard let error = throwed as? Error else {
            fail(
                "expected: \(Error.self), throwed: \(type(of: throwed))",
                file: file,
                line: line)
            return
        }
        guard expected == error else {
            fail(
                "expected: \(expected), throwed: \(throwed))",
                file: file,
                line: line)
            return
        }
    }
}
