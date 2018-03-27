import XCTest

public func scope(_ task: () throws -> Void) {
    do {
        try task()
    } catch {
        XCTFail(String(describing: error))
    }
}
