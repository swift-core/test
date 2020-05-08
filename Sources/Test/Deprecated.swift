import XCTest

@available(*, deprecated, message: "please use `expect(...)`")
public func assert(
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

@available(*, deprecated, message: "please use `expect(...)`")
public func assertNil(
    _ expression: @autoclosure () throws -> Any?,

    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTAssertNil(
        try expression(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertNotNil(
    _ expression: @autoclosure () throws -> Any?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTAssertNotNil(
        try expression(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertTrue(
    _ expression: @autoclosure () throws -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTAssertTrue(
        try expression(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertFalse(
    _ expression: @autoclosure () throws -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTAssertFalse(
        try expression(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : Equatable
{
    XCTAssertEqual(
        try expression1(),
        try expression2(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : FloatingPoint
{
    XCTAssertEqual(
        try expression1(),
        try expression2(),
        accuracy: accuracy,
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertGreaterThan<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : Comparable
{
    XCTAssertGreaterThan(
        try expression1(),
        try expression2(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertGreaterThanOrEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : Comparable
{
    XCTAssertGreaterThanOrEqual(
        try expression1(),
        try expression2(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertLessThan<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : Comparable
{
    XCTAssertLessThan(
        try expression1(),
        try expression2(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertLessThanOrEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : Comparable
{
    XCTAssertLessThanOrEqual(
        try expression1(),
        try expression2(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertNotEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : Equatable
{
    XCTAssertNotEqual(
        try expression1(),
        try expression2(),
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertNotEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) where T : FloatingPoint
{
    XCTAssertNotEqual(
        try expression1(),
        try expression2(),
        accuracy: accuracy,
        message(),
        file: file,
        line: line)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertThrowsError<T>(
    _ expression: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in })
{
    XCTAssertThrowsError(
        try expression(),
        message(),
        file: file,
        line: line,
        errorHandler)
}

@available(*, deprecated, message: "please use `expect(...)`")
public func assertNoThrow<T>(
    _ expression: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line)
{
    XCTAssertNoThrow(
        try expression(),
        message(),
        file: file,
        line: line)
}
