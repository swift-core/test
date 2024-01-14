extension Test {
    class Case {
        typealias Task = () async throws -> Void

        enum Failure {
            struct Info {
                let message: String
                let file: StaticString
                let line: UInt
            }
            case handled(Info)
            case unhandled(Swift.Error)
        }

        let name: String
        let task: Task
        var expectations: Int
        var failures: [Failure]

        init(name: String, task: @escaping Task) {
            self.name = name
            self.task = task
            self.expectations = 0
            self.failures = []
        }
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
