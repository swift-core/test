import class Foundation.NSCondition

public class AtomicCondition {
    var satisfied = false
    let condition = NSCondition()

    public init() {}

    public func signal() {
        condition.lock()
        satisfied = true
        condition.signal()
        condition.unlock()
    }

    public func wait() {
        condition.lock()
        if !satisfied {
            condition.wait()
        }
        condition.unlock()
    }
}
