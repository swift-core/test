@discardableResult
public func asyncTask(
    file: StaticString = #filePath,
    line: UInt = #line,
    _ task: @Sendable @escaping () async throws -> Void,
    deinit: @Sendable @escaping () async throws -> Void = {}
) -> Task<Void, Error> {
    detach {
        do {
            try await task()
            try await `deinit`()
        } catch {
            fail(String(describing: error), file: file, line: line)
            try await `deinit`()
        }
    }
}
