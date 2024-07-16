import Elementary
import ElementaryHTMX

public extension HTMLAttributeValue.HTMX.Extension {
    static var sse: Self { "sse" }
}

public extension HTMLAttributeValue.HTMX.EventTrigger {
    static func sse(_ eventName: String) -> Self {
        .init(rawValue: "sse:\(eventName)")
    }
}
