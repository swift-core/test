#if canImport(ObjectiveC)
import Darwin.C
#else
import Glibc
#endif

public let test = Test()

public class Test {
    var cases: [Case] = []
    var currentCase: Case! = nil

    var expectationsCount: Int { cases.reduce(0, { $0 + $1.expectations }) }
    var failuresCount: Int { cases.reduce(0, { $0 + $1.failures.count }) }
}

extension Test {
    public func run(_ fileID: String = #fileID) async {
        printCurrentSuite(fileID)

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
}

extension Test {
    private func getSuiteName(from fileID: String) -> Substring {
        let folder = fileID.dropLast("/main.swift".count)
        return folder.starts(with: "Tests_")
            ? folder.dropFirst("Tests_".count)
            : folder
    }

    func printCurrentSuite(_ fileID: String) {
        print("starting test suite", getSuiteName(from: fileID))
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
