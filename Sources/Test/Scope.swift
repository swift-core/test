import XCTest

public func scope(
    file: StaticString = #filePath,
    line: UInt = #line,
    task: () throws -> Void)
{
    do {
        try task()
    } catch {
        XCTFail(String(describing: error), file: file, line: line)
    }
}
