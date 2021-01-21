public func scope(
    file: StaticString = #filePath,
    line: UInt = #line,
    task: () async throws -> Void) async
{
    do {
        try await task()
    } catch {
        fail(String(describing: error), file: file, line: line)
    }
}
