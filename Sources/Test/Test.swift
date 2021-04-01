#if canImport(ObjectiveC)
import Darwin.C
#else
import Glibc
#endif

public let test = Test()

public class Test {
    private var cases: [Case] = []
    private var currentCase: Case! = nil

    var expectationsCount: Int { cases.reduce(0, { $0 + $1.expectations }) }
    var failuresCount: Int { cases.reduce(0, { $0 + $1.failures.count }) }

    public func `case`(_ name: String, task: @escaping Case.Task) {
        cases.append(.init(name: name, task: task))
    }

    public func run(_ fileID: String = #fileID) {
        _runAsyncMain() {
            await self._run(fileID)
        }
    }

    public func _run(_ fileID: String = #fileID) async {
        print("starting test suite", getSuiteName(from: fileID))

        for i in 0..<cases.count {
            currentCase = cases[i]
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
            self.fail(.unhandled(error))
        }
    }

    func registerExpectation() {
        currentCase.expectations += 1
    }

    func fail(_ failure: Case.Failure) {
        currentCase.failures.append(failure)
    }

    private func getSuiteName(from fileID: String) -> Substring {
        let folder = fileID.dropLast("/main.swift".count)
        return folder.starts(with: "Tests_")
            ? folder.dropFirst("Tests_".count)
            : folder
    }

    func printCurrentCase(_ case: Case) {
        print("test", `case`.name, terminator: ": ")
    }

    func printCurrentCaseResult(_ case: Case) {
        switch `case`.failures.count {
        case 0:
            print("✅")
        default:
            print("🛑")
            `case`.failures.forEach { print(" " + $0.description) }
        }
    }

    func printTotalResults() {
        print(
            "\n",
            failuresCount, "failures in",
            cases.count, "tests with",
            expectationsCount, "expectations",
            "\n")
    }
}

extension Test.Case.Failure: CustomStringConvertible {
    var description: String {
        switch self {
        case .handled(let info): return info.description
        case .unhandled(let error): return "unhandled error: \(error)"
        }
    }
}

extension Test.Case.Failure.Info: CustomStringConvertible {
    var description: String {
        var file = file.description
        if file.starts(with: "/home") || file.starts(with: "/Users") {
            var components = file.split(separator: "/")
            components.removeFirst(2)
            components.insert("~", at: 0)
            file = components.joined(separator: "/")
        }
        return "\(file):\(line) \(message)"
    }
}
