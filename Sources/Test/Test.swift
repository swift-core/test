#if canImport(ObjectiveC)
import Darwin.C
#else
import Glibc
#endif

class Test {
    static let shared = Test()

    var cases: [Case] = []
    var currentCase: Case! = nil

    var expectationsCount: Int { cases.reduce(0, { $0 + $1.expectations }) }
    var failuresCount: Int { cases.reduce(0, { $0 + $1.failures.count }) }

    private init() {}
}

extension Test {
    func registerExpectation() {
        currentCase.expectations += 1
    }

    func `case`(_ name: String, task: @escaping Case.Task) {
        cases.append(.init(name: name, task: task))
    }

    func scope(
        file: StaticString = #file,
        line: UInt = #line,
        task: () async throws -> Void
    ) async {
        do {
            try await task()
        } catch {
            fail(String(describing: error), file: file, line: line)
        }
    }

    func fail(_ failure: Case.Failure) {
        currentCase.failures.append(failure)
    }

    func run(_ fileID: String = #fileID) async {
        printCurrentSuite(fileID)

        for index in 0..<cases.count {
            currentCase = cases[index]
            printCurrentCase(currentCase)
            await run(currentCase)
            printCurrentCaseResult(currentCase)
            currentCase = nil
        }

        printTotalResults()

        if failuresCount > 0 {
            exit(1)
        }
    }

    func run(_ case: Case) async {
        do {
            try await `case`.task()
        } catch {
            fail(.unhandled(error))
        }
    }
}
