@testable import Test

class TestTests: TestCase {
    func testExpect() {
        expect(true == true)
        expect(true != false)
        expect(42 > 0)
    }

    func testExpectMessage() {
        expect(true == true, "two true to be true")
    }

    func testExpectError() {
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

    func testThrows() {
        func throwsError() throws {}
        scope {
            try throwsError()
        }
    }

    func testLifetime() {
        class Test {
            let descrtuctor: () -> Void

            init(_ descrtuctor: @escaping () -> Void) {
                self.descrtuctor = descrtuctor
            }

            deinit {
                descrtuctor()
            }
        }

        var called = false
        scope {
            _ = Test {
                called = true
            }
        }
        expect(called == true)
    }
}
