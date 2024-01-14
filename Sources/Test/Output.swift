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
        case 0 where `case`.expectations == 0:
            print("☑️")
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
