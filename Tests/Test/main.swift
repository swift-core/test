@testable import Test

test.case("Expect") {
    expect(true == true)
    expect(true != false)
    expect(42 > 0)
}

test.case("ExpectMessage") {
    expect(true == true, "two true to be true")
}

test.case("ExpectError") {
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

test.case("AsyncExpectError") {
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

test.case("Throws") {
    func throwsError() throws {}
    await scope {
        try throwsError()
    }
}

test.case("Lifetime") {
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

await test.run()
