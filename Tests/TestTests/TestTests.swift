@testable import Test

class TestTests: TestCase {
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
        assertTrue(called)
    }
}
