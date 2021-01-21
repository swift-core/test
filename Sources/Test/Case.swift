extension Test {
    public class Case {
        public typealias Task = () async throws -> Void

        enum Failure {
            struct Info {
                let message: String
                let file: StaticString
                let line: UInt
            }
            case handled(Info)
            case unhandled(Swift.Error)
        }

        public let name: String
        public let task: Task
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
