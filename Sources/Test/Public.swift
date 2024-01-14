public func test(
    _ name: String,
    task: @escaping () async throws -> Void
) {
    Test.shared.case(name, task: task)
}

public func scope(
    file: StaticString = #file,
    line: UInt = #line,
    task: () async throws -> Void
) async {
    await Test.shared.scope(file: file, line: line, task: task)
}

public func expect(
    _ expression: Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    Test.shared.expect(expression, message(), file: file, line: line)
}

public func expect<Error: Swift.Error, Result>(
    throws error: Error,
    file: StaticString = #file,
    line: UInt = #line,
    _ expression: @escaping () async throws -> Result
) async where Error: Equatable {
    await Test.shared.expect(throws: error, file: file, line: line, expression)
}

public func expect<Error: Swift.Error, Result>(
    throws error: Error,
    file: StaticString = #file,
    line: UInt = #line,
    _ expression: @escaping () throws -> Result
) where Error: Equatable {
    Test.shared.expect(throws: error, file: file, line: line, expression)
}

public func fail(
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    Test.shared.fail(message(), file: file, line: line)
}

public func run(_ fileID: String = #fileID) async {
    await Test.shared.run(fileID)
}
