import XCTest

public typealias TestCase = XCTestCase

public func expect(
    _ expression: @autoclosure () throws -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTAssert(
        try expression(),
        message(),
        file: file,
        line: line)
}

public func expect<Error: Swift.Error, Result>(
    throws error: Error,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line,
    _ expression: () throws -> Result) where Error: Equatable
{
    func errorHandler(_error: Swift.Error) {
        guard let __error = _error as? Error else {
            fail(
                "expected: \(Error.self), throwed: \(type(of: _error))",
                file: file,
                line: line)
            return
        }
        expect(error == __error, message(), file: file, line: line)
    }

    XCTAssertThrowsError(
        try expression(),
        message(),
        file: file,
        line: line,
        errorHandler)
}

public func fail(
    _ message: String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTFail(message, file: file, line: line)
}
