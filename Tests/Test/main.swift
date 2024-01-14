@testable import Test

test("Expect") {
    expect(true == true)
    expect(true != false)
    expect(42 > 0)
}

test("ExpectMessage") {
    expect(true == true, "two true to be true")
}

test("ExpectError") {
    enum Error: Swift.Error {
        case bsod
    }

    func runVisualStudio() throws {
        throw Error.bsod
    }

    expect(throws: Error.bsod) {
        try runVisualStudio()
    }
}

test("AsyncExpectError") {
    enum Error: Swift.Error {
        case bsod
    }

    func runVisualStudio() async throws {
        throw Error.bsod
    }

    await expect(throws: Error.bsod) {
        try await runVisualStudio()
    }
}

test("Throws") {
    func throwsError() throws {}
    await scope {
        try throwsError()
    }
}

test("Lifetime") {
    class Test {
        let destructor: () -> Void

        init(_ destructor: @escaping () -> Void) {
            self.destructor = destructor
        }

        deinit {
            destructor()
        }
    }

    var success = false
    await scope {
        _ = Test { success = true }
    }
    expect(success)
}

await run()
