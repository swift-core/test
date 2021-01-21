@discardableResult
public func asyncTask(
    file: StaticString = #filePath,
    line: UInt = #line,
    _ task: @concurrent @escaping () async throws -> Void,
    deinit: @concurrent @escaping () async throws -> Void = {}
) -> Task.Handle<Void, Never> {
    Task.runDetached {
        do {
            try await task()
            try await `deinit`()
        } catch {
            fail(String(describing: error), file: file, line: line)
            try await `deinit`()
        }
    }
}
